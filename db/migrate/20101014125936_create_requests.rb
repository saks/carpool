class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
    	t.belongs_to :user
      t.string :from
      t.string :to
      t.time :time
      t.integer :places_number
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end

