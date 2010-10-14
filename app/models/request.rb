class Request < ActiveRecord::Base
	belongs_to :user

	def self.free
		find(:all, :conditions => "places_number > 0")
	end

end

