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

ActiveRecord::Schema[8.0].define(version: 2026_02_04_141950) do
  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distributors", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stock_keeping_unit_id"
    t.index ["stock_keeping_unit_id"], name: "index_items_on_stock_keeping_unit_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distributor_id", null: false
    t.integer "item_id", null: false
    t.index ["distributor_id"], name: "index_orders_on_distributor_id"
    t.index ["item_id"], name: "index_orders_on_item_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_keeping_units", force: :cascade do |t|
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distributor_id", null: false
    t.integer "product_id", null: false
    t.index ["distributor_id"], name: "index_stock_keeping_units_on_distributor_id"
    t.index ["product_id"], name: "index_stock_keeping_units_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distributor_id"
    t.integer "admin_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["admin_id"], name: "index_users_on_admin_id"
    t.index ["distributor_id"], name: "index_users_on_distributor_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "stock_keeping_units"
  add_foreign_key "orders", "distributors"
  add_foreign_key "orders", "items"
  add_foreign_key "stock_keeping_units", "distributors"
  add_foreign_key "stock_keeping_units", "products"
  add_foreign_key "users", "admins"
  add_foreign_key "users", "distributors"
end
