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

ActiveRecord::Schema.define(version: 20170206221029) do

  create_table "acceptance_criteria", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "card_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "last_board_id"
    t.integer  "last_user_id"
    t.integer  "board_id"
    t.string   "color"
    t.integer  "sprint_id"
    t.integer  "position"
    t.string   "html_id"
    t.integer  "work_to_do"
    t.boolean  "is_user_story"
    t.string   "priority"
    t.boolean  "done"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "change_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sprint_card_id"
    t.string   "text"
    t.string   "username"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dashboards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimated_works", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "estimation_round_id"
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "estimated_days"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "estimation_rounds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sprint_card_id"
    t.integer  "round_number"
    t.integer  "card_id"
    t.boolean  "active"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_projects_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_projects_users_on_user_id", using: :btree
  end

  create_table "roadmap_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "is_user_story"
    t.boolean  "is_feature"
    t.integer  "roadmap_row_id"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "roadmap_rows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sprint_nr"
    t.boolean  "is_milestone"
    t.string   "title"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "roadmaps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sprint_nr"
    t.boolean  "is_milestone"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sprint_boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "sprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sprint_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "last_sprint_board_id"
    t.integer  "last_user_id"
    t.integer  "user_id"
    t.string   "username"
    t.integer  "priority"
    t.integer  "position"
    t.integer  "sprint_board_id"
    t.integer  "card_id"
    t.boolean  "visible"
    t.string   "change_request"
    t.string   "color"
    t.string   "label"
    t.integer  "work_to_do"
    t.integer  "work_done"
    t.boolean  "released"
    t.integer  "matching_card_id"
    t.string   "html_id"
    t.integer  "sprint_id"
    t.boolean  "done"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sprint_retro_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "text"
    t.integer  "sprint_id"
    t.boolean  "pro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sprints", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dashboard_id"
    t.integer  "sprint_number"
    t.boolean  "active"
    t.boolean  "started"
    t.boolean  "finished"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "statistics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "work_total"
    t.integer  "work_done"
    t.integer  "work_left"
    t.integer  "sprint_id"
    t.integer  "dashboard_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "work_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "text"
    t.integer  "estimation_round_id"
    t.string   "user_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
