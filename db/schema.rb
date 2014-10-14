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

ActiveRecord::Schema.define(version: 20141012174054) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "price"
  end

  create_table "materials_prices", id: false, force: true do |t|
    t.integer "material_id"
    t.integer "price_id"
  end

  create_table "materials_products", id: false, force: true do |t|
    t.integer "material_id"
    t.integer "product_id"
  end

  create_table "materials_shades", id: false, force: true do |t|
    t.integer "material_id"
    t.integer "shade_id"
  end

  create_table "our_works", force: true do |t|
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "prices", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.integer  "price"
    t.string   "button_color"
    t.integer  "position_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
  end

  create_table "shades", force: true do |t|
    t.string   "color"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
