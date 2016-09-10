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

ActiveRecord::Schema.define(version: 20160823053858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "dblink"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "campaigns", force: :cascade do |t|
    t.string   "label",            limit: 255
    t.datetime "exp_date"
    t.string   "campaign_end_url", limit: 255
    t.string   "hash_tag",         limit: 255
    t.string   "media_url",        limit: 255
    t.string   "media_thumb_url",  limit: 255
    t.boolean  "two_way_campaign"
    t.boolean  "is_active"
    t.boolean  "is_embed_media"
    t.datetime "schedule_on"
    t.integer  "user_id"
    t.integer  "campaign_type_id"
    t.integer  "share_medium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",           limit: 255
    t.boolean  "is_archived",                  default: false
    t.string   "slug",             limit: 255
    t.boolean  "is_power_share"
    t.text     "campaign_uuid"
    t.integer  "service_user_id"
    t.string   "time_zone",        limit: 255
  end

  add_index "campaigns", ["service_user_id"], name: "index_campaigns_on_service_user_id", using: :btree
  add_index "campaigns", ["slug"], name: "index_campaigns_on_slug", using: :btree
  
  create_table "csv_details", force: :cascade do |t|
    t.integer "job_id",                    null: false
    t.string  "state",         limit: 255
    t.integer "company_id"
    t.string  "item_code",     limit: 255
    t.boolean "is_active"
    t.string  "name",          limit: 255
    t.float   "price"
    t.string  "type",          limit: 255
    t.text    "description"
    t.text    "primary_image"
    t.json    "media"
    t.json    "details"
    t.string  "category",      limit: 255
    t.string  "sub_category",  limit: 255
    t.json    "row"
    t.json    "message"
    t.string  "catalog_group"
  end

  add_index "csv_details", ["job_id"], name: "ix_csv_details_job_id", using: :btree

  create_table "csv_upload", force: :cascade do |t|
    t.integer  "user_id",               null: false
    t.string   "stage",     limit: 255
    t.string   "file_name", limit: 255
    t.json     "col_types"
    t.datetime "added_on",              null: false
  end

  add_index "csv_upload", ["user_id"], name: "ix_csv_upload_user_id", using: :btree

  create_table "csvs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  
  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",                default: 0
    t.integer  "attempts",                default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",   limit: 255
    t.string   "queue",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.boolean  "share_now"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  

  create_table "devices", force: :cascade do |t|
    t.string   "device_id",  limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",              limit: 255,                 null: false
    t.boolean  "is_default",                    default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "profile"
    t.boolean  "visible_to_tenant"
  end
  
  create_table "tenants", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "address",           limit: 255
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                     default: true
    t.string   "redirect_url",      limit: 255
    t.string   "from_number",       limit: 255
    t.float    "lat"
    t.float    "lng"
    t.string   "phone",             limit: 255
    t.string   "contact_number",    limit: 255
    t.string   "email",             limit: 255
    t.string   "website_url",       limit: 255
    t.string   "facebook_url",      limit: 255
    t.string   "twitter_url",       limit: 255
    t.string   "linkedin_url",      limit: 255
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "tenant_region_id"
    t.integer  "tenant_type_id"
    t.text     "tenant_info"
  end

 

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "authentication_token",   limit: 255
    t.text     "uid"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.boolean  "subscribe",                          default: false
    t.datetime "exp_date"
    t.boolean  "is_active"
    t.integer  "failed_attempts"
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.integer  "role_id"
    t.integer  "tenant_id"
    t.boolean  "is_csv_processed",                   default: true
    t.string   "security_token",         limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar_url",             limit: 255
    t.string   "mobile",                 limit: 255
    t.integer  "currency_id"
    t.string   "invite_code",            limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["parent_id"], name: "index_users_on_parent_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id", using: :btree

  add_foreign_key "campaign_access", "inq_campaigns", column: "campaign_id", name: "campaign_access_campaign_id_fkey"
  add_foreign_key "campaign_feedback_details", "campaign_responses", column: "response_id", name: "campaign_feedback_details_response_id_fkey"
  add_foreign_key "template_industry", "templates", name: "template_industry_template_id_fkey"
  add_foreign_key "template_tags", "templates", name: "template_tags_template_id_fkey"
end
