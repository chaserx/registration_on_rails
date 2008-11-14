class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations, :id => false do |t|
      t.string :id, :limit => 22, :null => false
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :status
      t.string :dept
      t.integer :eveningsession, :limit => 1
      t.integer :guest, :limit => 1
      t.integer :partysize
      t.integer :lunch, :limit => 1
      t.string :bizperson
      t.string :bizpersonemail
      t.string :bizpersonphone

      t.timestamps
    end
    
    execute "ALTER TABLE registrations ADD PRIMARY KEY (id)"
  end

  def self.down
    drop_table :registrations
  end
end
