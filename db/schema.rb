# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081124205834) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brain_busters", :force => true do |t|
    t.string "question"
    t.string "answer"
  end

  create_table "registrations", :force => true do |t|
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "status"
    t.string   "dept"
    t.integer  "eveningsession",        :limit => 1
    t.integer  "guest",                 :limit => 1
    t.integer  "partysize"
    t.integer  "lunch",                 :limit => 1
    t.string   "bizperson"
    t.string   "bizpersonemail"
    t.string   "bizpersonphone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization"
    t.string   "abstract_file_name"
    t.string   "abstract_content_type"
    t.integer  "abstract_file_size"
    t.datetime "abstract_updated_at"
    t.float    "fees"
  end

end
