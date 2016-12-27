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

ActiveRecord::Schema.define(version: 20161227192447) do

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.integer  "last_board_id"
    t.integer  "last_user_id"
    t.integer  "board_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dashboards", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sprint_boards", force: :cascade do |t|
    t.string   "title"
    t.integer  "sprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sprint_cards", force: :cascade do |t|
    t.string   "title"
    t.integer  "last_sprint_board_id"
    t.integer  "last_user_id"
    t.integer  "user_id"
    t.integer  "priority"
    t.integer  "position"
    t.integer  "sprint_board_id"
    t.boolean  "visible"
    t.string   "change_request"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sprints", force: :cascade do |t|
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
