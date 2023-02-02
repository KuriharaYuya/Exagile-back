# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_31_151742) do
  create_table "appoint_characters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "appoint_id"
    t.string "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appoints", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "title"
    t.string "desc"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["end"], name: "index_appoints_on_end"
    t.index ["start"], name: "index_appoints_on_start"
    t.index ["user_id"], name: "fk_rails_7eac5482d4"
  end

  create_table "characters", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.text "profile"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_53a8ea746c"
  end

  create_table "characters_communities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "character_id", null: false
    t.string "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "communities", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id", null: false
    t.index ["user_id"], name: "fk_rails_cac8c778bb"
  end

  create_table "faq_tag_relations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "faq_id", null: false
    t.string "faq_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faq_tags", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "fk_rails_7e2cbfb739"
  end

  create_table "faqs", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "inspired_appoint_id"
    t.string "applied_appoint_id"
    t.index ["user_id"], name: "fk_rails_901529645b"
  end

  create_table "insights", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "title", limit: 60, null: false
    t.text "content"
    t.string "appoint_id", null: false
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "reviewed_at"
    t.boolean "concerning", default: false
    t.index ["appoint_id"], name: "fk_rails_012a331203"
    t.index ["user_id"], name: "fk_rails_d0e6fe893c"
  end

  create_table "topic_ideas", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "appoint_id"
    t.string "user_id", null: false
    t.string "character_id", null: false
    t.string "title", null: false
    t.string "content"
    t.boolean "done", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "fk_rails_9926023cab"
    t.index ["user_id"], name: "fk_rails_fe9557582c"
  end

  create_table "topics", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "character_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "appoint_id", null: false
    t.index ["appoint_id"], name: "fk_rails_6d133fbabd"
    t.index ["character_id"], name: "fk_rails_107ac67050"
  end

  create_table "users", primary_key: "uid", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.text "manipulate_options"
  end

  add_foreign_key "appoints", "users", primary_key: "uid"
  add_foreign_key "characters", "users", primary_key: "uid", on_delete: :cascade
  add_foreign_key "communities", "users", primary_key: "uid"
  add_foreign_key "faq_tags", "users", primary_key: "uid", on_delete: :cascade
  add_foreign_key "faqs", "users", primary_key: "uid", on_delete: :cascade
  add_foreign_key "insights", "appoints"
  add_foreign_key "insights", "users", primary_key: "uid"
  add_foreign_key "topic_ideas", "characters"
  add_foreign_key "topic_ideas", "users", primary_key: "uid"
  add_foreign_key "topics", "appoints", on_delete: :cascade
  add_foreign_key "topics", "characters", on_delete: :cascade
end
