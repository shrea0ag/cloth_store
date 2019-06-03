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

ActiveRecord::Schema.define(version: 2019_06_03_071123) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "borrowees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "phone"
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
    t.string "name"
    t.integer "phone"
    t.index ["email"], name: "index_borrowers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_borrowers_on_reset_password_token", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.string "size"
    t.string "color"
    t.decimal "total"
    t.integer "borrower_id"
    t.integer "product_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["borrower_id"], name: "index_order_items_on_borrower_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "actual_return_date"
    t.string "status", default: "processing"
    t.decimal "total"
    t.string "address"
    t.string "phone"
    t.date "expected_return_date"
    t.integer "days"
    t.integer "borrower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["borrower_id"], name: "index_orders_on_borrower_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.string "token"
    t.string "transaction_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
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
    t.string "gender"
    t.integer "quantity", default: 20
    t.index ["borrowee_id"], name: "index_products_on_borrowee_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keywords"
    t.decimal "min_price"
    t.decimal "max_price"
    t.string "name"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
