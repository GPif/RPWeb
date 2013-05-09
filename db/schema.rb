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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130509101105) do

  create_table "career_entries", :force => true do |t|
    t.integer  "career_id"
    t.integer  "next_career_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "careers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "ws"
    t.integer  "bs"
    t.integer  "s"
    t.integer  "t"
    t.integer  "ag"
    t.integer  "wp"
    t.integer  "fel"
    t.integer  "a"
    t.integer  "w"
    t.integer  "mag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "skills_desc"
    t.text     "talents_desc"
    t.text     "trappings_desc"
    t.text     "entry_desc"
    t.text     "exit_desc"
    t.integer  "int"
    t.integer  "sb"
    t.integer  "tb"
    t.integer  "m"
    t.integer  "ip"
    t.integer  "fp"
  end

  create_table "character_competences", :force => true do |t|
    t.integer  "character_id"
    t.integer  "competence_id"
    t.integer  "bonus"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "base_weapon_skill"
    t.integer  "base_balistic_skill"
    t.integer  "base_strength"
    t.integer  "base_toughness"
    t.integer  "base_agility"
    t.integer  "base_intelligence"
    t.integer  "base_will_power"
    t.integer  "base_fellowship"
    t.integer  "base_attacks"
    t.integer  "base_wounds"
    t.integer  "base_mouvement"
    t.integer  "base_insanity_points"
    t.integer  "base_fate_points"
    t.integer  "race_id"
    t.integer  "age"
    t.string   "gender"
    t.string   "eye_color"
    t.integer  "weight"
    t.string   "hair_color"
    t.integer  "height"
    t.string   "star_sign"
    t.string   "number_of_sibling"
    t.string   "birthplace"
    t.text     "distinguishing_marks"
    t.integer  "career_id"
    t.integer  "base_magic"
  end

  add_index "characters", ["user_id"], :name => "index_characters_on_user_id"

  create_table "characters_talents", :id => false, :force => true do |t|
    t.integer "character_id", :null => false
    t.integer "talent_id",    :null => false
  end

  create_table "competences", :force => true do |t|
    t.string   "name"
    t.string   "characteristic"
    t.boolean  "base"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talents", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "login"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
