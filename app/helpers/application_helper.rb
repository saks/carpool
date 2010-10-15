# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def may_edit?(request)
		cookies[:carpool_key].to_i == request.id
	end

end

