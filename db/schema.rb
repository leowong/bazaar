# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100718154733) do

  create_table "assets", :force => true do |t|
    t.integer   "viewable_id"
    t.string    "viewable_type"
    t.string    "attachment_file_name"
    t.string    "attachment_content_type"
    t.integer   "attachment_file_size"
    t.timestamp "attachment_updated_at"
    t.integer   "position"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "contact"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "composer_id"
    t.boolean  "news",        :default => false
  end

  create_table "pages", :force => true do |t|
    t.string    "slug"
    t.string    "title"
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name",            :default => "",    :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         :default => 0,     :null => false
    t.decimal  "price",           :default => 0.0
    t.integer  "assets_count",    :default => 0
    t.integer  "pageviews_count", :default => 0
    t.string   "permalink"
    t.integer  "category_id"
    t.boolean  "published",       :default => false
  end

  add_index "products", ["permalink"], :name => "index_products_on_permalink"

  create_table "sessions", :force => true do |t|
    t.string    "session_id", :null => false
    t.text      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "product_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "username"
    t.string    "email"
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "persistence_token"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "address"
    t.string    "store_name"
    t.decimal   "latitude",          :default => 0.0
    t.decimal   "longitude",         :default => 0.0
    t.text      "description"
    t.integer   "roles_mask"
    t.string    "contact"
    t.string    "abbreviation"
  end

end
