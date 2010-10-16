class RequestsController < ApplicationController
	def index
		@request = Request.new
		@requests = Request.find :all, :order => 'time'
	end

	def search
		#XXX only `from` and `to` params are used. All other params are ignored now

		result = Request.find_all_by_from_and_to params[:from], params[:to]

		render :json => {
			:requests => result,
			:drivers  => User.all,
		}
	end

	def create
		time = Time.parse "#{params[:request]['date']} #{params[:request]['hours']}:#{params[:request]['minutes']}"

		user = User.find_or_create_by_phone_number params[:request].delete 'phone_number'
		user.name = params[:request].delete 'name'
		user.save!
    busy = params[:request]['places_number'].to_i - params[:request]['empty'].to_i
		request = user.requests.create({
			:from          => params[:request]['from'],
			:to            => params[:request]['to'],
			:comment       => params[:request]['comment'],
			:time          => time,
			:places_number => params[:request]['places_number'].to_i < 0 ? 0 : params[:request]['places_number'],
			:busy          => busy < 0 ? 0 : busy,
		})

		cookies[:carpool_key] = {
			:value => request.id.to_s,
			:expires => 3.days.from_now
		}

		redirect_to root_path
	end

	def show
		@request = Request.find params[:id]
	end

  def edit    
    @request = Request.find params[:id]
    render_404 unless may_edit?(@request)
  end

  def delete
    @request = Request.find params[:id]
    if may_edit?(@request)
      @request.delete
      redirect_to root_path
    else  
      render_404
    end
  end

	def update
		@request = Request.find params[:id]
		
    user = User.find @request.user_id
    user.phone_number = params[:request].delete 'phone_number'
    user.name = params[:request].delete 'name'
    user.save!
    
    @request.time = Time.parse "#{params[:request].delete('date')} #{params[:request].delete('hours')}:#{params[:request].delete('minutes')}";
    @request.busy = params[:request]['places_number'].to_i - params[:request].delete('empty').to_i
    @request.busy = 0 unless @request.busy > 0
    @request.save!
    
		@request.update_attributes params[:request]
		redirect_to root_path
	end

	def accept
		@request = Request.find params[:id]
		@request.busy += 1 if @request.busy < @request.places_number
		@request.save

		render :text => @request.places_number - @request.busy
	end

	def free
		@request = Request.find params[:id]
		@request.busy -= 1 if @request.busy > 0
		@request.save

		render :text => @request.places_number - @request.busy
	end

end