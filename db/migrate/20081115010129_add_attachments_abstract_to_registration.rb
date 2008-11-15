class AddAttachmentsAbstractToRegistration < ActiveRecord::Migration
  def self.up
    add_column :registrations, :abstract_file_name, :string
    add_column :registrations, :abstract_content_type, :string
    add_column :registrations, :abstract_file_size, :integer
    add_column :registrations, :abstract_updated_at, :datetime
  end

  def self.down
    remove_column :registrations, :abstract_file_name
    remove_column :registrations, :abstract_content_type
    remove_column :registrations, :abstract_file_size
    remove_column :registrations, :abstract_updated_at
  end
end
