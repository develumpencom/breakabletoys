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

ActiveRecord::Schema[8.0].define(version: 2025_03_04_004451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.text "description"
    t.string "redirect_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "oauth_application_credentials", force: :cascade do |t|
    t.bigint "application_id", null: false
    t.string "client_id", null: false
    t.string "client_secret", null: false
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_oauth_application_credentials_on_application_id"
    t.index ["client_id"], name: "index_oauth_application_credentials_on_client_id", unique: true
    t.index ["client_secret"], name: "index_oauth_application_credentials_on_client_secret", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "toys", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "url"
    t.string "short_description", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "role", limit: 2, default: 0
    t.string "kit_id"
    t.string "kit_state"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "applications", "users"
  add_foreign_key "oauth_application_credentials", "applications"
  add_foreign_key "sessions", "users"
end
