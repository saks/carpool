class RequestsController < ApplicationController
	def index
		@request = Request.new
		@requests = Request.find :all, :order => 'time'
	end

	def create
		time = Time.parse "#{params[:request]['date']} #{params[:request]['hours']}:#{params[:request]['minutes']}"

		user = User.find_or_create_by_phone_number params[:request].delete 'phone_number'
		user.name = params[:request].delete 'name'
		user.save!

		user.requests.create({
			:from          => params[:request]['from'],
			:to            => params[:request]['to'],
			:comment       => params[:request]['description'],
			:time          => time,
			:places_number => params[:request]['places_number'],
			:busy          => 0,
		})
		redirect_to root_path
	end

	def accept
		@request = Request.find params[:id]
		@request.busy += 1 if @request.busy < @request.places_number
		@request.save

		render :text => @request.places_number.to_s
	end

	def accept
		@request = Request.find params[:id]
		@request.busy -= 1 if @request.busy > 0
		@request.save

		render :text => @request.places_number.to_s
	end


end

