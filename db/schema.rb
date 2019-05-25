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

ActiveRecord::Schema.define(version: 2019_05_24_115702) do

  create_table "borrowees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_borrowees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_borrowees_on_reset_password_token", unique: true
  end

  create_table "borrowers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_borrowers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_borrowers_on_reset_password_token", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "borrower_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.string "size"
    t.string "color"
    t.date "expected_return_date"
    t.index ["borrower_id"], name: "index_order_items_on_borrower_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "borrower_id"
    t.integer "order_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "processing"
    t.string "address"
    t.integer "phone"
    t.decimal "total"
    t.date "actual_return_date"
    t.index ["borrower_id"], name: "index_orders_on_borrower_id"
    t.index ["order_item_id"], name: "index_orders_on_order_item_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "borrowee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "size_xs"
    t.boolean "size_s"
    t.boolean "size_m"
    t.boolean "size_l"
    t.boolean "size_xl"
    t.decimal "price"
    t.string "color"
    t.integer "count", default: 4
    t.index ["borrowee_id"], name: "index_products_on_borrowee_id"
  end

end
