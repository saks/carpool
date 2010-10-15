class AddBusyToRequests < ActiveRecord::Migration
	def self.up
		add_column :requests, :busy, :integer
	end

	def self.down
		remove_column :requests, :busy
	end
end

