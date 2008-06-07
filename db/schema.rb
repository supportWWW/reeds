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

ActiveRecord::Schema.define(:version => 20080607034217) do

  create_table "assignments", :force => true do |t|
    t.integer  "branch_id",      :limit => 11
    t.integer  "salesperson_id", :limit => 11
    t.boolean  "enabled",                      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "size",         :limit => 11
    t.string   "filename"
    t.string   "content_type"
    t.integer  "owner_id",     :limit => 11
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
    t.integer  "parent_id",    :limit => 11
    t.integer  "owner_id",     :limit => 11
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "title"
    t.integer  "page_id",    :limit => 11
    t.string   "path"
    t.integer  "parent_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :limit => 11
    t.integer  "depth",      :limit => 11
  end

  create_table "news_articles", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "source_url"
    t.string   "title_permalink"
    t.text     "text"
    t.text     "rendered_text"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",     :limit => 11
  end

  add_index "news_articles", ["title_permalink"], :name => "index_news_articles_on_title_permalink", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "title_permalink"
    t.text     "text"
    t.text     "rendered_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", :force => true do |t|
    t.string   "name"
    t.string   "source"
    t.text     "description"
    t.integer  "visits_count", :limit => 11, :default => 0
    t.string   "redirect_to",                :default => "/"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salespeople", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "is_admin",                                 :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "visits", :force => true do |t|
    t.integer  "referral_id",  :limit => 11
    t.string   "referer"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referer_host"
  end

end
