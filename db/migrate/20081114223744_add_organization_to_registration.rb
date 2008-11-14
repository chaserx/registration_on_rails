class AddOrganizationToRegistration < ActiveRecord::Migration
  def self.up
    add_column :registrations, :organization, :string
  end

  def self.down
    remove_column :registrations, :organization
  end
end
