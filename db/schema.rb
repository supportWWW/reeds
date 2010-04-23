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

ActiveRecord::Schema.define(:version => 20100421140348) do

  create_table "accessories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_in_cents"
    t.integer  "new_vehicle_id",  :null => false
    t.string   "model_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "excl_in_cents"
    t.integer  "vat_in_cents"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "salesperson_id"
    t.boolean  "enabled",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["branch_id"], :name => "index_assignments_on_branch_id"
  add_index "assignments", ["salesperson_id"], :name => "index_assignments_on_salesperson_id"

  create_table "attachments", :force => true do |t|
    t.integer  "size"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "attachments", ["owner_id"], :name => "index_attachments_on_owner_id"
  add_index "attachments", ["owner_type"], :name => "index_attachments_on_owner_type"

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "phone"
    t.string   "fax"
    t.string   "stock_code_prefix"
    t.string   "cyberstock_prefix"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifieds", :force => true do |t|
    t.string   "stock_code"
    t.integer  "model_variant_id"
    t.integer  "price_in_cents"
    t.string   "colour"
    t.string   "reg_num"
    t.integer  "mileage"
    t.text     "features"
    t.integer  "days_in_stock"
    t.datetime "removed_at"
    t.boolean  "has_service_history"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.integer  "make_id"
    t.integer  "model_id"
    t.string   "permalink"
    t.date     "expires_on"
    t.string   "type"
    t.string   "physical_stock"
    t.integer  "branch_id"
  end

  add_index "classifieds", ["model_variant_id"], :name => "index_classifieds_on_model_variant_id"
  add_index "classifieds", ["price_in_cents"], :name => "index_classifieds_on_price_in_cents"
  add_index "classifieds", ["stock_code"], :name => "index_classifieds_on_stock_code", :unique => true

  create_table "emails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "last_send_attempt", :default => 0
    t.text     "mail"
    t.datetime "created_on"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_submits", :force => true do |t|
    t.string   "form_name",  :limit => 32, :null => false
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "thumbnail"
    t.string   "type"
    t.integer  "position"
  end

  add_index "images", ["owner_id"], :name => "index_images_on_owner_id"
  add_index "images", ["owner_type"], :name => "index_images_on_owner_type"
  add_index "images", ["parent_id"], :name => "index_images_on_parent_id"

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.string   "common_name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "makes", ["name"], :name => "index_makes_on_name", :unique => true

  create_table "menu_items", :force => true do |t|
    t.string   "title"
    t.integer  "page_id"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "depth"
  end

  add_index "menu_items", ["page_id"], :name => "index_menu_items_on_page_id"
  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"

  create_table "model_ranges", :force => true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "model_variants", :force => true do |t|
    t.integer  "model_id"
    t.integer  "year"
    t.string   "mead_mcgrouther_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "model_variants", ["mead_mcgrouther_code"], :name => "index_model_variants_on_mead_mcgrouther_code"
  add_index "model_variants", ["model_id"], :name => "index_model_variants_on_model_id"
  add_index "model_variants", ["year"], :name => "index_model_variants_on_year"

  create_table "models", :force => true do |t|
    t.string   "name"
    t.string   "common_name"
    t.integer  "make_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["make_id"], :name => "index_models_on_make_id"
  add_index "models", ["name"], :name => "index_models_on_name"

  create_table "new_vehicle_variants", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_in_cents"
    t.string   "model_reference"
    t.integer  "new_vehicle_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "excl_in_cents"
    t.integer  "vat_in_cents"
    t.integer  "make_id"
    t.integer  "model_range_id"
    t.string   "permalink"
  end

  create_table "new_vehicles", :force => true do |t|
    t.integer  "model_range_id"
    t.text     "description"
    t.integer  "year"
    t.boolean  "enabled",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
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
    t.integer  "category_id"
  end

  add_index "news_articles", ["category_id"], :name => "index_news_articles_on_category_id"
  add_index "news_articles", ["title_permalink"], :name => "index_news_articles_on_title_permalink", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "title_permalink"
    t.text     "text"
    t.text     "rendered_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["title_permalink"], :name => "index_pages_on_title_permalink", :unique => true

  create_table "promotion_boxes", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "active"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "style"
    t.text     "rendered_body"
  end

  create_table "referrals", :force => true do |t|
    t.string   "name"
    t.string   "source"
    t.text     "description"
    t.integer  "visits_count", :default => 0
    t.string   "redirect_to",  :default => "/"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salespeople", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "job_title"
    t.boolean  "sms_contact_me"
    t.boolean  "receive_web_leads"
  end

  create_table "specials", :force => true do |t|
    t.string   "title"
    t.string   "title_permalink"
    t.text     "text"
    t.text     "rendered_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "slideshow",       :default => false
    t.boolean  "enabled",         :default => true
  end

  create_table "stats", :force => true do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.date     "date"
    t.string   "referer"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["parent_type", "parent_id", "date"], :name => "index_stats_on_parent_type_and_parent_id_and_date"

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

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "visits", :force => true do |t|
    t.integer  "referral_id"
    t.string   "referer"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referer_host"
  end

  add_index "visits", ["referral_id"], :name => "index_visits_on_referral_id"

end
