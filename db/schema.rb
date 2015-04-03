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

ActiveRecord::Schema.define(version: 20150403042453) do

  create_table "Monsters", force: true do |t|
    t.string   "name"
    t.float    "cr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "terrain_id"
  end

  add_index "Monsters", ["terrain_id"], name: "index_monsters_on_terrain_id"

  create_table "monsters_terrains", id: false, force: true do |t|
    t.integer "monster_id"
    t.integer "terrain_id"
  end

  add_index "monsters_terrains", ["monster_id", "terrain_id"], name: "index_monsters_terrains_on_monster_id_and_terrain_id"
  add_index "monsters_terrains", ["terrain_id"], name: "index_monsters_terrains_on_terrain_id"

  create_table "terrains", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
