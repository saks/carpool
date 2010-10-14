class RequestsController < ApplicationController
	def index
		@request = Request.new
		@requests = Request.find :all, :order => 'time'
	end

	def create
		time = Time.parse "#{params[:request]['date']} #{params[:request]['hours']}:#{params[:request]['minutes']}"
		p time

		user = User.find_or_create_by_phone_number params[:request].delete 'phone_number'
		user.name = params[:request].delete 'name'
		user.save!

		user.requests.create({
			:from          => params[:request]['from'],
			:to            => params[:request]['to'],
			:comment       => params[:request]['description'],
			:time          => time,
			:places_number => params[:request]['places_number'],
		})
		redirect_to root_path
	end

	def accept

	end

end

