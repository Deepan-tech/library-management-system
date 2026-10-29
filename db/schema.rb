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

ActiveRecord::Schema[8.1].define(version: 2026_10_24_143610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "admin_name"
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "authors", force: :cascade do |t|
    t.string "author_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "book_copies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.string "barcode"
    t.string "copy_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_copies_on_book_id"
  end

  create_table "book_genres", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_genres_on_book_id"
    t.index ["genre_id"], name: "index_book_genres_on_genre_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.string "edition"
    t.date "publication_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "book_copy_id", null: false
    t.date "barrowed_at"
    t.date "due_at"
    t.date "return_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_copy_id"], name: "index_statuses_on_book_copy_id"
    t.index ["student_id"], name: "index_statuses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.string "username"
    t.string "email"
    t.string "mobile"
    t.datetime "last_Login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["department_id"], name: "index_students_on_department_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.string "username"
    t.string "eamil"
    t.string "mobile"
    t.datetime "last_Login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "book_copies", "books"
  add_foreign_key "book_genres", "books"
  add_foreign_key "book_genres", "genres"
  add_foreign_key "statuses", "book_copies"
  add_foreign_key "statuses", "students"
  add_foreign_key "students", "departments"
  add_foreign_key "users", "departments"
end
