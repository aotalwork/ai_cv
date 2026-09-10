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

ActiveRecord::Schema[8.1].define(version: 2026_09_10_091334) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "position"
    t.bigint "profile_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_achievements_on_profile_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "profile_id", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "year"
    t.index ["profile_id"], name: "index_certifications_on_profile_id"
  end

  create_table "educations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "degree"
    t.integer "end_year"
    t.string "institution"
    t.bigint "profile_id", null: false
    t.integer "start_year"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["profile_id"], name: "index_educations_on_profile_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "client"
    t.string "company"
    t.string "company_url"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.string "position"
    t.bigint "profile_id"
    t.string "project_url"
    t.date "start_date"
    t.text "technologies"
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_experiences_on_profile_id"
  end

  create_table "languages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "level"
    t.string "name"
    t.bigint "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_languages_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "github_url"
    t.string "headline"
    t.string "linkedin_url"
    t.string "location"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.bigint "profile_id"
    t.string "technologies"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["profile_id"], name: "index_projects_on_profile_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "author"
    t.string "author_role"
    t.string "company"
    t.text "content"
    t.datetime "created_at", null: false
    t.date "date"
    t.bigint "profile_id", null: false
    t.text "summary"
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_recommendations_on_profile_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "profile_id"
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_skills_on_profile_id"
  end

  add_foreign_key "achievements", "profiles"
  add_foreign_key "certifications", "profiles"
  add_foreign_key "educations", "profiles"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "languages", "profiles"
  add_foreign_key "projects", "profiles"
  add_foreign_key "recommendations", "profiles"
  add_foreign_key "skills", "profiles"
end
