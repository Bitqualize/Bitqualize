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

ActiveRecord::Schema.define(version: 20131109084457) do

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "currency_id"
    t.decimal  "balance"
    t.decimal  "balance_available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id", "currency_id"], name: "IX_ACCOUNTS_1", unique: true

  create_table "announcements", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "long_name"
    t.boolean  "process_deposits"
    t.boolean  "allow_withdrawals"
    t.boolean  "process_orders"
    t.decimal  "deposit_min_amount"
    t.decimal  "deposit_max_daily_amount"
    t.decimal  "withdrawal_max_daily_amount"
    t.decimal  "fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "currencies", ["name"], name: "index_currencies_on_name", unique: true

  create_table "deposits", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gacodes", force: true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gacodes", ["user_id"], name: "index_gacodes_on_user_id"

  create_table "gausers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gausers", ["user_id"], name: "index_gausers_on_user_id"

  create_table "logindetails", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oldorders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orderexecutions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parameters", force: true do |t|
    t.string   "paramname"
    t.string   "paramvalue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parameters", ["paramname"], name: "index_parameters_on_paramname", unique: true

  create_table "trxhistories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "language"
    t.string   "password_digest"
    t.string   "activation_token"
    t.datetime "active_since"
    t.boolean  "is_locked"
    t.string   "reset_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_token"], name: "index_users_on_reset_token"

  create_table "withdrawals", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
