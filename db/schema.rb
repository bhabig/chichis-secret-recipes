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

ActiveRecord::Schema.define(version: 20170726190559) do

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.boolean  "allergen_warning", default: false
    t.integer  "spice_level"
    t.integer  "ingredient_type"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "status"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.string   "measurement"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "category"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "cook_time"
    t.text     "instructions"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "category"
    t.string   "recipe_avatar_file_name"
    t.string   "recipe_avatar_content_type"
    t.integer  "recipe_avatar_file_size"
    t.datetime "recipe_avatar_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "admin",                    default: false
    t.integer  "uid"
    t.string   "user_avatar_file_name"
    t.string   "user_avatar_content_type"
    t.integer  "user_avatar_file_size"
    t.datetime "user_avatar_updated_at"
  end

end
