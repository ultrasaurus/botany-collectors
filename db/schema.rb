# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140902011157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emu_people", force: true do |t|
    t.integer  "count"
    t.integer  "irn"
    t.string   "full_name"
    t.string   "brief_name"
    t.string   "birth_date"
    t.string   "death_date"
    t.string   "bio_location"
    t.string   "start_date"
    t.string   "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.string   "edan_id"
    t.string   "image_uri"
    t.text     "description"
    t.string   "object_type"
    t.integer  "emu_person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
