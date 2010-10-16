class AddPriceToRequests < ActiveRecord::Migration
	def self.up
		add_column :requests, :price, :integer
	end

	def self.down
		remove_column :requests, :price
	end
end

