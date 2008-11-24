class AddFeesColumnToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :fees, :float
  end

  def self.down
    remove_column :registrations, :fees
  end
end
