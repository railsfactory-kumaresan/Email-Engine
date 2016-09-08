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

  create_table "action_lists", force: :cascade do |t|
    t.string   "action",     limit: 255
    t.float    "weight"
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "line1",      limit: 255
    t.string   "line2",      limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.integer  "pincode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  create_table "alert_channels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alert_configs", force: :cascade do |t|
    t.text     "email"
    t.text     "sms"
    t.text     "business_app"
    t.text     "consumer_app"
    t.integer  "alert_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alert_configs", ["alert_event_id"], name: "index_alert_configs_on_alert_event_id", using: :btree

  create_table "alert_event_channels", force: :cascade do |t|
    t.boolean  "is_active"
    t.integer  "alert_event_id"
    t.integer  "alert_channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alert_event_channels", ["alert_channel_id"], name: "index_alert_event_channels_on_alert_channel_id", using: :btree
  add_index "alert_event_channels", ["alert_event_id"], name: "index_alert_event_channels_on_alert_event_id", using: :btree

  create_table "alert_events", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.boolean  "is_set_on"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "alert_id"
    t.integer  "alert_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
  end

  add_index "alert_events", ["alert_id"], name: "index_alert_events_on_alert_id", using: :btree
  add_index "alert_events", ["alert_type_id"], name: "index_alert_events_on_alert_type_id", using: :btree
  add_index "alert_events", ["user_id"], name: "index_alert_events_on_user_id", using: :btree

  create_table "alert_logs", force: :cascade do |t|
    t.text     "event_params"
    t.string   "event_post_id",    limit: 255
    t.boolean  "is_viewed"
    t.integer  "user_id"
    t.integer  "alert_event_id"
    t.integer  "alert_channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alert_logs", ["alert_channel_id"], name: "index_alert_logs_on_alert_channel_id", using: :btree
  add_index "alert_logs", ["alert_event_id"], name: "index_alert_logs_on_alert_event_id", using: :btree
  add_index "alert_logs", ["user_id"], name: "index_alert_logs_on_user_id", using: :btree

  create_table "alert_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answer_analyses", force: :cascade do |t|
    t.integer  "answer_id",       null: false
    t.integer  "question_id",     null: false
    t.integer  "sentiment_score", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_analyses", ["answer_id"], name: "index_answer_analyses_on_answer_id", using: :btree
  add_index "answer_analyses", ["question_id"], name: "analyses_question_id", using: :btree

  create_table "answer_options", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.hstore   "options",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_options", ["question_id"], name: "index_answer_options_on_question_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "customers_info_id"
    t.integer  "question_id"
    t.string   "provider",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comments",           limit: 255
    t.text     "free_text"
    t.integer  "question_option_id"
    t.integer  "question_type_id"
    t.string   "option",             limit: 255
    t.integer  "date"
    t.integer  "month"
    t.integer  "year"
    t.integer  "hour"
    t.boolean  "is_business_user"
    t.boolean  "is_deactivated"
    t.boolean  "is_other",                       default: false
    t.integer  "uuid"
  end

  add_index "answers", ["customers_info_id"], name: "index_answers_on_customers_info_id", using: :btree
  add_index "answers", ["question_id"], name: "answers_index", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["question_option_id"], name: "index_answers_on_question_option_id", using: :btree
  add_index "answers", ["question_type_id"], name: "index_answers_on_question_type_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "attachable_type",    limit: 255
    t.integer  "attachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree
  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree

  create_table "backlog_email_lists", force: :cascade do |t|
    t.text     "email_array",                default: "{}"
    t.string   "bitly_url",      limit: 255
    t.text     "subject"
    t.text     "message"
    t.string   "sender_email",   limit: 255
    t.string   "question_image", limit: 255
    t.string   "ref_message_id", limit: 255
    t.string   "status",         limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_type",     limit: 255
    t.string   "attach_path",    limit: 255
    t.string   "attach_type",    limit: 255
    t.string   "attach_name",    limit: 255
    t.boolean  "is_html"
    t.integer  "question_id"
  end

  create_table "beacons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "uid",        limit: 255
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_info_details", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "billing_name",    limit: 255
    t.string   "billing_email",   limit: 255
    t.string   "billing_address", limit: 255
    t.string   "billing_city",    limit: 255
    t.string   "billing_state",   limit: 255
    t.string   "billing_country", limit: 255
    t.integer  "billing_zip",     limit: 8
    t.string   "billing_phone",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "billing_info_details", ["user_id"], name: "index_billing_info_details_on_user_id", using: :btree

  create_table "business_customer_infos", force: :cascade do |t|
    t.string   "mobile",             limit: 255
    t.string   "customer_name",      limit: 255
    t.string   "email",              limit: 255
    t.boolean  "response_status"
    t.boolean  "view_status"
    t.string   "gender",             limit: 255
    t.string   "question_id",        limit: 255
    t.string   "provider",           limit: 255
    t.date     "date_of_birth"
    t.integer  "age"
    t.integer  "user_id"
    t.string   "country",            limit: 255
    t.string   "state",              limit: 255
    t.string   "city",               limit: 255
    t.string   "area",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cookie_token_id"
    t.boolean  "is_deleted"
    t.string   "custom_field",       limit: 255
    t.string   "status",             limit: 255, default: "f"
    t.integer  "consumer_id"
    t.boolean  "is_active_consumer"
  end

  add_index "business_customer_infos", ["consumer_id"], name: "index_business_customer_infos_on_consumer_id", using: :btree
  add_index "business_customer_infos", ["cookie_token_id"], name: "index_business_customer_infos_on_cookie_token_id", using: :btree
  add_index "business_customer_infos", ["country"], name: "index_business_customer_infos_on_country", using: :btree
  add_index "business_customer_infos", ["email"], name: "index_business_customer_infos_on_email", using: :btree
  add_index "business_customer_infos", ["question_id"], name: "index_business_customer_infos_on_question_id", using: :btree
  add_index "business_customer_infos", ["user_id"], name: "index_business_customer_infos_on_user_id", using: :btree

  create_table "campaign_access", force: :cascade do |t|
    t.integer  "campaign_id",                   null: false
    t.integer  "creator_id",                    null: false
    t.integer  "access_user",                   null: false
    t.string   "access_mode",       limit: 255, null: false
    t.string   "access_permission", limit: 255, null: false
    t.datetime "added_on",                      null: false
  end

  add_index "campaign_access", ["access_mode"], name: "ix_campaign_access_access_mode", using: :btree
  add_index "campaign_access", ["access_permission"], name: "ix_campaign_access_access_permission", using: :btree
  add_index "campaign_access", ["access_user"], name: "ix_campaign_access_access_user", using: :btree
  add_index "campaign_access", ["campaign_id", "creator_id", "access_user"], name: "campaign_access_campaign_id_creator_id_access_user_key", unique: true, using: :btree
  add_index "campaign_access", ["campaign_id"], name: "ix_campaign_access_campaign_id", using: :btree
  add_index "campaign_access", ["creator_id"], name: "ix_campaign_access_creator_id", using: :btree

  create_table "campaign_activity_stats", force: :cascade do |t|
    t.string   "post_id",         limit: 255
    t.string   "channel",         limit: 255
    t.integer  "campaign_id"
    t.integer  "views"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "connections"
    t.integer  "reach"
    t.integer  "share_medium_id"
  end

  create_table "campaign_alert_exception_log", force: :cascade do |t|
    t.integer  "response_id",              null: false
    t.string   "campaign_id",  limit: 255, null: false
    t.text     "exception"
    t.datetime "triggered_on",             null: false
  end

  add_index "campaign_alert_exception_log", ["campaign_id"], name: "ix_campaign_alert_exception_log_campaign_id", using: :btree
  add_index "campaign_alert_exception_log", ["response_id"], name: "ix_campaign_alert_exception_log_response_id", using: :btree

  create_table "campaign_alert_log", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.integer  "alert_id",                         null: false
    t.integer  "engage_alert_id"
    t.string   "alert_name",           limit: 255, null: false
    t.string   "campaign_id",          limit: 255, null: false
    t.integer  "response_id",                      null: false
    t.json     "place_holders"
    t.integer  "http_response_code"
    t.integer  "server_response_code"
    t.json     "server_response"
    t.datetime "triggered_on",                     null: false
    t.datetime "responded_on"
  end

  add_index "campaign_alert_log", ["alert_id"], name: "ix_campaign_alert_log_alert_id", using: :btree
  add_index "campaign_alert_log", ["alert_name"], name: "ix_campaign_alert_log_alert_name", using: :btree
  add_index "campaign_alert_log", ["campaign_id"], name: "ix_campaign_alert_log_campaign_id", using: :btree
  add_index "campaign_alert_log", ["engage_alert_id"], name: "ix_campaign_alert_log_engage_alert_id", using: :btree
  add_index "campaign_alert_log", ["response_id"], name: "ix_campaign_alert_log_response_id", using: :btree
  add_index "campaign_alert_log", ["user_id"], name: "ix_campaign_alert_log_user_id", using: :btree

  create_table "campaign_alerts", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.string   "campaign_id",     limit: 255, null: false
    t.integer  "engage_alert_id"
    t.boolean  "is_active",                   null: false
    t.string   "name",            limit: 255
    t.json     "conditions"
    t.datetime "added_on",                    null: false
    t.datetime "updated_on",                  null: false
  end

  add_index "campaign_alerts", ["campaign_id"], name: "ix_campaign_alerts_campaign_id", using: :btree
  add_index "campaign_alerts", ["is_active"], name: "ix_campaign_alerts_is_active", using: :btree
  add_index "campaign_alerts", ["name"], name: "ix_campaign_alerts_name", using: :btree
  add_index "campaign_alerts", ["user_id"], name: "ix_campaign_alerts_user_id", using: :btree

  create_table "campaign_channels", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "share_medium_id"
    t.integer  "user_channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_id",         limit: 255
    t.integer  "connections"
    t.integer  "reach"
  end

  add_index "campaign_channels", ["campaign_id"], name: "index_campaign_channels_on_campaign_id", using: :btree
  add_index "campaign_channels", ["share_medium_id"], name: "index_campaign_channels_on_share_medium_id", using: :btree
  add_index "campaign_channels", ["user_channel_id"], name: "index_campaign_channels_on_user_channel_id", using: :btree

  create_table "campaign_customers", force: :cascade do |t|
    t.integer  "campaign_channel_id"
    t.integer  "campaign_id"
    t.integer  "business_customer_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_customers", ["business_customer_info_id"], name: "index_campaign_customers_on_business_customer_info_id", using: :btree
  add_index "campaign_customers", ["campaign_channel_id"], name: "index_campaign_customers_on_campaign_channel_id", using: :btree
  add_index "campaign_customers", ["campaign_id"], name: "index_campaign_customers_on_campaign_id", using: :btree

  create_table "campaign_customisations", force: :cascade do |t|
    t.string   "background",        limit: 255
    t.string   "question_text",     limit: 255
    t.string   "answer_text",       limit: 255
    t.string   "button_text",       limit: 255
    t.string   "button_background", limit: 255
    t.integer  "font_style_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_details", force: :cascade do |t|
    t.text     "campaign_data"
    t.text     "campaign_short_urls"
    t.integer  "campaign_id"
    t.integer  "share_medium_id"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_details", ["campaign_id"], name: "index_campaign_details_on_campaign_id", using: :btree
  add_index "campaign_details", ["share_medium_id"], name: "index_campaign_details_on_share_medium_id", using: :btree
  add_index "campaign_details", ["template_id"], name: "index_campaign_details_on_template_id", using: :btree

  create_table "campaign_feedback_details", force: :cascade do |t|
    t.integer  "response_id",                null: false
    t.string   "campaign_id",    limit: 255, null: false
    t.string   "channel",        limit: 255
    t.string   "question_type",  limit: 255
    t.string   "question_id",    limit: 255
    t.string   "option_id",      limit: 255
    t.text     "question_text"
    t.text     "option_value"
    t.integer  "question_score"
    t.integer  "score"
    t.datetime "responded_on",               null: false
    t.string   "sentiment",      limit: 255
  end

  add_index "campaign_feedback_details", ["campaign_id"], name: "ix_campaign_feedback_details_campaign_id", using: :btree
  add_index "campaign_feedback_details", ["channel"], name: "ix_campaign_feedback_details_channel", using: :btree
  add_index "campaign_feedback_details", ["option_id"], name: "ix_campaign_feedback_details_option_id", using: :btree
  add_index "campaign_feedback_details", ["question_id"], name: "ix_campaign_feedback_details_question_id", using: :btree
  add_index "campaign_feedback_details", ["question_type"], name: "ix_campaign_feedback_details_question_type", using: :btree
  add_index "campaign_feedback_details", ["response_id"], name: "ix_campaign_feedback_details_response_id", using: :btree

  create_table "campaign_report_frequency", force: :cascade do |t|
    t.string   "campaign_id",      limit: 255,                 null: false
    t.string   "frequency",        limit: 255,                 null: false
    t.boolean  "is_active",                    default: false, null: false
    t.json     "email_recipients"
    t.text     "subject"
    t.string   "timezone",         limit: 255
    t.datetime "added_on",                                     null: false
  end

  add_index "campaign_report_frequency", ["campaign_id"], name: "ix_campaign_report_frequency_campaign_id", using: :btree
  add_index "campaign_report_frequency", ["frequency"], name: "ix_campaign_report_frequency_frequency", using: :btree
  add_index "campaign_report_frequency", ["is_active"], name: "ix_campaign_report_frequency_is_active", using: :btree

  create_table "campaign_responses", force: :cascade do |t|
    t.string   "campaign_id",      limit: 255, null: false
    t.string   "channel",          limit: 255
    t.string   "campaign_type",    limit: 255
    t.string   "customer_name",    limit: 255
    t.string   "customer_mobile",  limit: 255
    t.string   "customer_email",   limit: 255
    t.json     "customer_details"
    t.json     "feedback"
    t.integer  "score"
    t.integer  "total_score"
    t.datetime "responded_on",                 null: false
    t.string   "replied_via",      limit: 255
    t.json     "reply"
    t.datetime "replied_on"
  end

  add_index "campaign_responses", ["campaign_id"], name: "ix_campaign_responses_campaign_id", using: :btree
  add_index "campaign_responses", ["channel"], name: "ix_campaign_responses_channel", using: :btree

  create_table "campaign_themes", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.boolean  "is_active",                default: false, null: false
    t.integer  "company_id"
    t.json     "data"
    t.json     "preview_data"
    t.datetime "added_on",                                 null: false
  end

  add_index "campaign_themes", ["is_active"], name: "ix_campaign_themes_is_active", using: :btree
  add_index "campaign_themes", ["name"], name: "campaign_themes_name_key", unique: true, using: :btree
  add_index "campaign_themes", ["name"], name: "ix_campaign_themes_name", using: :btree

  create_table "campaign_types", force: :cascade do |t|
    t.string   "campaign_type", limit: 255
    t.string   "name",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "cards", force: :cascade do |t|
    t.string   "uuid",            limit: 255,                 null: false
    t.string   "name",            limit: 255,                 null: false
    t.string   "title",           limit: 255
    t.text     "icon_html"
    t.text     "path"
    t.text     "tooltip"
    t.text     "description"
    t.string   "category",        limit: 255,                 null: false
    t.boolean  "is_active",                   default: false, null: false
    t.boolean  "is_valid",                    default: false, null: false
    t.boolean  "is_required",                 default: false, null: false
    t.text     "thumbnail"
    t.text     "view_attributes"
    t.text     "form_attributes"
    t.datetime "added_on",                                    null: false
    t.boolean  "inline_email"
    t.boolean  "supports_theme"
    t.text     "style"
  end

  add_index "cards", ["category"], name: "ix_cards_category", using: :btree
  add_index "cards", ["is_active"], name: "ix_cards_is_active", using: :btree
  add_index "cards", ["is_required"], name: "ix_cards_is_required", using: :btree
  add_index "cards", ["is_valid"], name: "ix_cards_is_valid", using: :btree
  add_index "cards", ["name"], name: "cards_name_key", unique: true, using: :btree
  add_index "cards", ["name"], name: "ix_cards_name", using: :btree
  add_index "cards", ["uuid"], name: "cards_uuid_key", unique: true, using: :btree
  add_index "cards", ["uuid"], name: "ix_cards_uuid", using: :btree

  create_table "category_types", force: :cascade do |t|
    t.string   "category_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_languages", force: :cascade do |t|
    t.integer  "client_setting_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_languages", ["client_setting_id"], name: "index_client_languages_on_client_setting_id", using: :btree
  add_index "client_languages", ["language_id"], name: "index_client_languages_on_language_id", using: :btree

  create_table "client_pricing_plans", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "client_type",            limit: 255
    t.integer  "email_count"
    t.integer  "sms_count"
    t.integer  "customer_records_count"
    t.integer  "campaigns_count"
    t.float    "fb_boost_budget"
    t.integer  "pricing_plan_id"
    t.boolean  "is_active"
    t.datetime "start_date"
    t.datetime "exp_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_reach"
  end

  create_table "client_settings", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.integer  "pricing_plan_id",                  null: false
    t.integer  "tenant_count"
    t.integer  "customer_records_count"
    t.integer  "language_count"
    t.integer  "business_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_hourly_quota",     limit: 8
    t.integer  "questions_count"
    t.integer  "video_photo_count"
    t.integer  "sms_count"
    t.integer  "call_count"
    t.integer  "email_count"
  end

  add_index "client_settings", ["pricing_plan_id"], name: "index_client_settings_on_pricing_plan_id", using: :btree
  add_index "client_settings", ["user_id"], name: "index_client_settings_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "address",         limit: 255
    t.string   "area",            limit: 255
    t.text     "description"
    t.integer  "company_type_id"
    t.integer  "industry_id"
    t.string   "website_url",     limit: 255
    t.string   "facebook_url",    limit: 255
    t.string   "twitter_url",     limit: 255
    t.string   "linkedin_url",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "redirect_url",    limit: 255
    t.integer  "piwik_id"
  end

  create_table "company_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_id"
    t.string   "auth_provider"
    t.string   "api_key"
    t.uuid     "uuid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "device_id"
    t.string   "password_digest"
    t.string   "token"
    t.string   "dob"
    t.string   "gender"
    t.string   "mobile"
    t.string   "image_url"
    t.boolean  "is_active",       default: true
  end

  create_table "contact_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_groups", ["user_id"], name: "index_contact_groups_on_user_id", using: :btree

  create_table "conversation_lists", force: :cascade do |t|
    t.integer  "consumer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cookie_tokens", force: :cascade do |t|
    t.string   "uuid",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counts_stores", force: :cascade do |t|
    t.integer  "question_id",                                                                                                                                                                                                                                                                                                                                                                        null: false
    t.string   "vrtype",      limit: 255,                                                                                                                                                                                                                                                                                                                                                            null: false
    t.integer  "norm_date",                                                                                                                                                                                                                                                                                                                                                                          null: false
    t.string   "country",     limit: 255
    t.hstore   "counts_key",              default: {"f"=>"0", "m"=>"0", "fb"=>"0", "lk"=>"0", "qr"=>"0", "tw"=>"0", "sms"=>"0", "tkc"=>"0", "af00"=>"0", "af17"=>"0", "af25"=>"0", "af30"=>"0", "af35"=>"0", "af40"=>"0", "af45"=>"0", "af50"=>"0", "am00"=>"0", "am17"=>"0", "am25"=>"0", "am30"=>"0", "am35"=>"0", "am40"=>"0", "am45"=>"0", "am50"=>"0", "call"=>"0", "mail"=>"0", "embed"=>"0"}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "counts_stores", ["counts_key"], name: "index_counts_stores_on_counts_key", using: :gin
  add_index "counts_stores", ["question_id"], name: "index_counts_stores_on_question_id", using: :btree

  create_table "cron_logs", force: :cascade do |t|
    t.integer  "last_run_id"
    t.string   "log_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "currencies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "salutation", limit: 255
    t.string   "landline",   limit: 255
    t.string   "mobile",     limit: 255
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers_contact_groups", id: false, force: :cascade do |t|
    t.integer "business_customer_info_id"
    t.integer "contact_group_id"
  end

  add_index "customers_contact_groups", ["business_customer_info_id"], name: "index_customers_contact_groups_on_business_customer_info_id", using: :btree
  add_index "customers_contact_groups", ["contact_group_id"], name: "index_customers_contact_groups_on_contact_group_id", using: :btree

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

  create_table "delivery_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id",  limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distribute_pricing_plans", force: :cascade do |t|
    t.string   "plan_name",             limit: 255, null: false
    t.boolean  "form_builder"
    t.boolean  "offline_mode"
    t.boolean  "nrts_results"
    t.integer  "surveys_count"
    t.integer  "responses_count"
    t.boolean  "tell_the_world"
    t.boolean  "multilingual"
    t.boolean  "professional_template"
    t.boolean  "multitenant_structure"
    t.boolean  "download_reports"
    t.boolean  "sentiment_analysis"
    t.string   "media_content",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_activities", force: :cascade do |t|
    t.integer  "opens"
    t.integer  "clicks"
    t.string   "subject",                   limit: 255
    t.string   "campaign_name",             limit: 255
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "business_customer_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enterprise_api_endpoints", force: :cascade do |t|
    t.string  "subdomain",      limit: 255
    t.string  "login_path",     limit: 255
    t.string  "logout_path",    limit: 255
    t.string  "forgot_pw_path", limit: 255
    t.string  "change_pw_path", limit: 255
    t.integer "user_id"
  end

  create_table "enterprise_contacts", force: :cascade do |t|
    t.string  "name",                       limit: 255
    t.string  "path",                       limit: 255
    t.integer "enterprise_api_endpoint_id"
    t.boolean "tenant_can_access"
    t.text    "params"
  end

  create_table "executive_business_mappings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "executive_business_mappings", ["company_id"], name: "index_executive_business_mappings_on_company_id", using: :btree
  add_index "executive_business_mappings", ["user_id"], name: "index_executive_business_mappings_on_user_id", using: :btree

  create_table "executive_tenant_mappings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tenant_id"
    t.integer  "client_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "executive_tenant_mappings", ["tenant_id"], name: "index_executive_tenant_mappings_on_tenant_id", using: :btree
  add_index "executive_tenant_mappings", ["user_id"], name: "index_executive_tenant_mappings_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.integer  "parent_id",                   null: false
    t.string   "controller_name", limit: 255, null: false
    t.string   "action_name",     limit: 255
    t.string   "title",           limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "font_styles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funnel_marketing_states", force: :cascade do |t|
    t.string   "action_name",    limit: 255
    t.text     "note"
    t.datetime "appointment_at"
    t.string   "result",         limit: 255
    t.integer  "funnel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funnel_sources", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "campaign_id"
    t.integer  "web_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funnel_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funnel_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funnels", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "quantity"
    t.boolean  "is_valid"
    t.integer  "funnel_state_id"
    t.integer  "delivery_type_id"
    t.integer  "customer_id"
    t.integer  "company_id"
    t.json     "spec_details"
    t.integer  "tracking_id"
    t.integer  "payment_mode_id"
    t.integer  "funnel_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "funnel_type_id"
    t.string   "campaign_id",               limit: 255
    t.integer  "delivery_boy_id"
    t.integer  "rating"
    t.integer  "funnel_marketing_state_id"
    t.string   "lead_title",                limit: 255
    t.string   "funnel_channel",            limit: 255
    t.integer  "owner_id"
  end

  create_table "industry_tags", force: :cascade do |t|
    t.string   "industry",   limit: 255
    t.string   "tag",        limit: 255
    t.datetime "added_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inq_campaigns", force: :cascade do |t|
    t.string   "uuid",             limit: 255, null: false
    t.integer  "user_id",                      null: false
    t.string   "name",             limit: 255, null: false
    t.string   "state",            limit: 255, null: false
    t.string   "hash_tag",         limit: 255, null: false
    t.string   "campaign_type",    limit: 255, null: false
    t.text     "redirect_url"
    t.text     "campaign_url"
    t.text     "preview_data"
    t.text     "override_preview"
    t.text     "cards"
    t.datetime "valid_till"
    t.datetime "scheduled_on"
    t.integer  "inq_campaign_id"
    t.text     "bitly_url"
    t.datetime "added_on",                     null: false
    t.text     "channel_preview"
    t.string   "approval_status"
    t.string   "mode"
    t.integer  "customer_id"
    t.string   "timezone",         limit: 255
    t.integer  "theme_id"
  end

  add_index "inq_campaigns", ["campaign_type"], name: "ix_inq_campaigns_campaign_type", using: :btree
  add_index "inq_campaigns", ["hash_tag"], name: "ix_inq_campaigns_hash_tag", using: :btree
  add_index "inq_campaigns", ["inq_campaign_id"], name: "ix_inq_campaigns_inq_campaign_id", using: :btree
  add_index "inq_campaigns", ["name"], name: "ix_inq_campaigns_name", using: :btree
  add_index "inq_campaigns", ["state"], name: "ix_inq_campaigns_state", using: :btree
  add_index "inq_campaigns", ["user_id", "name"], name: "inq_campaigns_user_id_name_key", unique: true, using: :btree
  add_index "inq_campaigns", ["user_id"], name: "ix_inq_campaigns_user_id", using: :btree
  add_index "inq_campaigns", ["uuid"], name: "inq_campaigns_uuid_key", unique: true, using: :btree
  add_index "inq_campaigns", ["uuid"], name: "ix_inq_campaigns_uuid", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.string   "invite_code",       limit: 255
    t.datetime "invite_expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_capture_details", force: :cascade do |t|
    t.integer  "company_id",                  null: false
    t.string   "type",            limit: 255
    t.json     "capture_details"
    t.datetime "added_on",                    null: false
    t.datetime "updated_on",                  null: false
    t.string   "catalog_group",               null: false
  end

  add_index "item_capture_details", ["company_id", "catalog_group", "type"], name: "item_capture_details_company_id_catalog_group_type_key", unique: true, using: :btree
  add_index "item_capture_details", ["company_id"], name: "ix_item_capture_details_company_id", using: :btree

  create_table "item_category", force: :cascade do |t|
    t.integer  "company_id",                null: false
    t.string   "item_code",     limit: 255, null: false
    t.string   "category",      limit: 255
    t.string   "sub_category",  limit: 255
    t.datetime "added_on",                  null: false
    t.string   "catalog_group",             null: false
  end

  add_index "item_category", ["company_id", "catalog_group", "item_code", "category", "sub_category"], name: "item_category_company_id_catalog_group_item_code_category_sub_c", unique: true, using: :btree
  add_index "item_category", ["company_id"], name: "ix_item_category_company_id", using: :btree
  add_index "item_category", ["item_code"], name: "ix_item_category_item_code", using: :btree

  create_table "item_pricing_model", force: :cascade do |t|
    t.integer  "company_id",                  null: false
    t.string   "type",            limit: 255
    t.json     "pricing_details"
    t.datetime "added_on",                    null: false
    t.datetime "updated_on",                  null: false
    t.string   "catalog_group",               null: false
  end

  add_index "item_pricing_model", ["company_id", "catalog_group", "type"], name: "item_pricing_model_company_id_catalog_group_type_key", unique: true, using: :btree
  add_index "item_pricing_model", ["company_id"], name: "ix_item_pricing_model_company_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "company_id",                null: false
    t.string   "item_code",     limit: 255, null: false
    t.boolean  "is_active",                 null: false
    t.string   "name",          limit: 255
    t.float    "price"
    t.string   "type",          limit: 255
    t.text     "description"
    t.text     "primary_image"
    t.json     "media"
    t.json     "details"
    t.datetime "added_on",                  null: false
    t.datetime "updated_on",                null: false
    t.string   "catalog_group",             null: false
  end

  add_index "items", ["catalog_group"], name: "ix_item_capture_details_catalog_group", using: :btree
  add_index "items", ["catalog_group"], name: "ix_item_category_catalog_group", using: :btree
  add_index "items", ["catalog_group"], name: "ix_item_pricing_model_details_catalog_group", using: :btree
  add_index "items", ["catalog_group"], name: "ix_items_catalog_group", using: :btree
  add_index "items", ["company_id", "catalog_group", "item_code"], name: "items_company_id_catalog_group_item_code_key", unique: true, using: :btree
  add_index "items", ["company_id"], name: "ix_items_company_id", using: :btree
  add_index "items", ["is_active"], name: "ix_items_is_active", using: :btree
  add_index "items", ["item_code"], name: "ix_items_item_code", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "consumer_id"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listeners", force: :cascade do |t|
    t.string   "client_id",    limit: 255
    t.integer  "user_id"
    t.string   "email",        limit: 255
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.string   "status",       limit: 255
    t.boolean  "is_active",                default: false
    t.boolean  "is_requested",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name", limit: 255
  end

  add_index "listeners", ["user_id"], name: "index_listeners_on_user_id", using: :btree

  create_table "payment_modes", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id",      null: false
    t.boolean  "access_level", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feature_id"
  end

  add_index "permissions", ["role_id"], name: "index_permissions_on_role_id", using: :btree

  create_table "pricing_category_types", force: :cascade do |t|
    t.integer  "category_type_id"
    t.integer  "pricing_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pricing_category_types", ["category_type_id"], name: "index_pricing_category_types_on_category_type_id", using: :btree
  add_index "pricing_category_types", ["pricing_plan_id"], name: "index_pricing_category_types_on_pricing_plan_id", using: :btree

  create_table "pricing_plan_channels", id: false, force: :cascade do |t|
    t.integer "plannable_id"
    t.integer "channel_id"
    t.integer "id"
    t.string  "plannable_type", limit: 255
  end

  create_table "pricing_plans", force: :cascade do |t|
    t.string   "name",                   limit: 255,                null: false
    t.string   "country",                limit: 255, default: "IN", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sms_count"
    t.integer  "email_count"
    t.float    "amount"
    t.integer  "campaigns_count"
    t.float    "fb_boost_budget"
    t.integer  "currency_id"
    t.boolean  "is_default"
    t.integer  "customer_records_count"
    t.integer  "total_reach"
    t.boolean  "is_active"
  end

  create_table "qr_code_campaigns", force: :cascade do |t|
    t.integer  "qr_code_id"
    t.integer  "campaign_id"
    t.string   "campaign_short_url", limit: 255
    t.string   "campaign_long_url",  limit: 255
    t.boolean  "is_scheduled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campaign_slug",      limit: 255
    t.boolean  "is_active"
  end

  add_index "qr_code_campaigns", ["campaign_slug"], name: "index_qr_code_campaigns_on_campaign_slug", using: :btree

  create_table "qr_codes", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "short_url",          limit: 255
    t.boolean  "status"
    t.boolean  "is_default"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug",               limit: 255
    t.string   "url",                limit: 255
    t.boolean  "is_active"
  end

  add_index "qr_codes", ["slug"], name: "index_qr_codes_on_slug", using: :btree
  add_index "qr_codes", ["url"], name: "index_qr_codes_on_url", using: :btree

  create_table "question_options", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "option",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.boolean  "is_other"
    t.boolean  "is_deactivated"
  end

  add_index "question_options", ["question_id"], name: "index_question_options_on_question_id", using: :btree

  create_table "question_response_logs", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "provider",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "cookie_token_id"
    t.boolean  "is_processed",                          default: true
    t.integer  "business_customer_info_id"
  end

  add_index "question_response_logs", ["cookie_token_id"], name: "index_question_response_logs_on_cookie_token_id", using: :btree
  add_index "question_response_logs", ["question_id"], name: "index_question_response_logs_on_question_id", using: :btree
  add_index "question_response_logs", ["user_id"], name: "index_question_response_logs_on_user_id", using: :btree

  create_table "question_styles", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "background",    limit: 255
    t.string   "page_header",   limit: 255
    t.string   "submit_button", limit: 255
    t.string   "question_text", limit: 255
    t.string   "button_text",   limit: 255
    t.string   "answers",       limit: 255
    t.string   "font_style",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_styles", ["question_id"], name: "index_question_styles_on_question_id", using: :btree

  create_table "question_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_view_logs", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "provider",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "cookie_token_id"
    t.boolean  "is_processed",                          default: true
    t.integer  "business_customer_info_id"
  end

  add_index "question_view_logs", ["cookie_token_id"], name: "index_question_view_logs_on_cookie_token_id", using: :btree
  add_index "question_view_logs", ["question_id"], name: "index_question_view_logs_on_question_id", using: :btree
  add_index "question_view_logs", ["user_id"], name: "index_question_view_logs_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_type_id"
    t.string   "expiration_id",      limit: 255
    t.string   "question",           limit: 255
    t.boolean  "include_other"
    t.boolean  "include_text"
    t.boolean  "include_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",             limit: 255, default: "Inactive"
    t.text     "thanks_response"
    t.datetime "expired_at"
    t.string   "qrcode_status",      limit: 255
    t.string   "embed_url",          limit: 255
    t.string   "video_url",          limit: 255
    t.integer  "question_type_id"
    t.integer  "video_type"
    t.string   "slug",               limit: 255
    t.string   "language",           limit: 255, default: "English"
    t.boolean  "private_access",                 default: false
    t.string   "short_url",          limit: 255
    t.string   "twitter_short_url",  limit: 255
    t.string   "linkedin_short_url", limit: 255
    t.string   "qrcode_short_url",   limit: 255
    t.string   "sms_short_url",      limit: 255
    t.integer  "view_count",                     default: 0
    t.integer  "response_count",                 default: 0
    t.string   "video_url_thumb",    limit: 255
    t.integer  "tenant_id"
    t.boolean  "embed_status",                   default: false
  end

  add_index "questions", ["category_type_id"], name: "index_questions_on_category_type_id", using: :btree
  add_index "questions", ["expiration_id"], name: "index_questions_on_expiration_id", using: :btree
  add_index "questions", ["question_type_id"], name: "index_questions_on_question_type_id", using: :btree
  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree
  add_index "questions", ["tenant_id"], name: "qs_tenant_id", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "response_cookie_infos", force: :cascade do |t|
    t.integer  "response_token_id"
    t.string   "response_token_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cookie_token_id"
  end

  add_index "response_cookie_infos", ["cookie_token_id"], name: "res_cookie_token_id", using: :btree
  add_index "response_cookie_infos", ["response_token_id"], name: "index_response_cookie_infos_on_response_token_id", using: :btree
  add_index "response_cookie_infos", ["response_token_type"], name: "res_response_token_type", using: :btree

  create_table "response_customer_infos", force: :cascade do |t|
    t.string   "mobile",          limit: 255
    t.string   "customer_name",   limit: 255
    t.string   "email",           limit: 255
    t.boolean  "response_status"
    t.boolean  "view_status"
    t.string   "gender",          limit: 255
    t.string   "question_id",     limit: 255
    t.string   "provider",        limit: 255
    t.date     "date_of_birth"
    t.integer  "age"
    t.string   "country",         limit: 255
    t.string   "state",           limit: 255
    t.string   "city",            limit: 255
    t.string   "area",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cookie_token_id"
    t.integer  "user_id"
    t.boolean  "is_deleted"
  end

  add_index "response_customer_infos", ["cookie_token_id"], name: "index_response_customer_infos_on_cookie_token_id", using: :btree
  add_index "response_customer_infos", ["question_id"], name: "index_response_customer_infos_on_question_id", using: :btree
  add_index "response_customer_infos", ["user_id"], name: "index_response_customer_infos_on_user_id", using: :btree

  create_table "revisions", force: :cascade do |t|
    t.text     "content"
    t.boolean  "is_updated"
    t.integer  "campaign_id"
    t.integer  "created_by"
    t.integer  "created_for"
    t.integer  "company_id"
    t.integer  "tenant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "revisions", ["campaign_id"], name: "index_revisions_on_campaign_id", using: :btree
  add_index "revisions", ["company_id"], name: "index_revisions_on_company_id", using: :btree
  add_index "revisions", ["created_by"], name: "index_revisions_on_created_by", using: :btree
  add_index "revisions", ["created_for"], name: "index_revisions_on_created_for", using: :btree
  add_index "revisions", ["tenant_id"], name: "index_revisions_on_tenant_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",              limit: 255,                 null: false
    t.boolean  "is_default",                    default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "profile"
    t.boolean  "visible_to_tenant"
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "s3_configs", force: :cascade do |t|
    t.text     "identity_name"
    t.text     "identity_pool_name"
    t.string   "identity_type",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_slots", force: :cascade do |t|
    t.string   "slot",             limit: 255
    t.integer  "schedule_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_types", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.boolean  "is_active"
    t.text     "schedule_days",             default: "---\nMONDAY: true\nTUESDAY: true\nWEDNESDAY: true\nTHURSDAY: true\nFRIDAY: true\nSATURDAY: true\nSUNDAY: true\n"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "share_details", force: :cascade do |t|
    t.integer  "customer_records_count", default: 0, null: false
    t.integer  "sms_count",              default: 0, null: false
    t.integer  "email_count",            default: 0, null: false
    t.integer  "user_id",                default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaigns_count"
    t.float    "fb_boost_budget"
    t.boolean  "is_current"
    t.integer  "client_pricing_plan_id"
    t.integer  "total_reach"
  end

  add_index "share_details", ["user_id"], name: "index_share_details_on_user_id", using: :btree

  create_table "share_mediums", force: :cascade do |t|
    t.string   "share_type", limit: 255
    t.boolean  "is_active",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "share_questions", force: :cascade do |t|
    t.string   "email_address",      limit: 255
    t.string   "provider",           limit: 255
    t.text     "social_id"
    t.text     "social_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                         default: false
    t.string   "user_name",          limit: 255
    t.text     "user_profile_image"
  end

  add_index "share_questions", ["social_id"], name: "index_share_questions_on_social_id", using: :btree
  add_index "share_questions", ["user_id"], name: "index_share_questions_on_user_id", using: :btree

  create_table "share_summaries", force: :cascade do |t|
    t.integer  "customer_records_count", default: 0, null: false
    t.integer  "sms_count",              default: 0, null: false
    t.integer  "email_count",            default: 0, null: false
    t.integer  "user_id",                default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fb_reach"
    t.integer  "campaign_id"
    t.integer  "share_detail_id"
  end

  add_index "share_summaries", ["user_id"], name: "index_share_summaries_on_user_id", using: :btree

  create_table "speakups", force: :cascade do |t|
    t.string   "business_name"
    t.string   "message"
    t.integer  "consumer_id"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "pincode"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "specifications", force: :cascade do |t|
    t.json     "attrs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "consumer_id"
    t.boolean  "is_active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "business_type"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_industry", force: :cascade do |t|
    t.integer  "template_id",             null: false
    t.string   "industry",    limit: 255, null: false
    t.datetime "added_on",                null: false
  end

  add_index "template_industry", ["industry"], name: "ix_template_industry_industry", using: :btree
  add_index "template_industry", ["template_id", "industry"], name: "template_industry_template_id_industry_key", unique: true, using: :btree
  add_index "template_industry", ["template_id"], name: "ix_template_industry_template_id", using: :btree

  create_table "template_tags", force: :cascade do |t|
    t.integer  "template_id",             null: false
    t.string   "tag",         limit: 255, null: false
    t.datetime "added_on",                null: false
  end

  add_index "template_tags", ["tag"], name: "ix_template_tags_tag", using: :btree
  add_index "template_tags", ["template_id", "tag"], name: "template_tags_template_id_tag_key", unique: true, using: :btree
  add_index "template_tags", ["template_id"], name: "ix_template_tags_template_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "uuid",              limit: 255,                 null: false
    t.string   "name",              limit: 255,                 null: false
    t.text     "cards"
    t.boolean  "is_active",                     default: false, null: false
    t.integer  "company_id"
    t.text     "preview_data"
    t.text     "thumbnail"
    t.text     "industry"
    t.text     "tags"
    t.string   "type",              limit: 255,                 null: false
    t.boolean  "updated_thumbnail",             default: false, null: false
    t.datetime "added_on",                                      null: false
    t.integer  "theme_id"
  end

  add_index "templates", ["is_active"], name: "ix_templates_is_active", using: :btree
  add_index "templates", ["name"], name: "ix_templates_name", using: :btree
  add_index "templates", ["name"], name: "templates_name_key", unique: true, using: :btree
  add_index "templates", ["type"], name: "ix_templates_type", using: :btree
  add_index "templates", ["updated_thumbnail"], name: "ix_templates_updated_thumbnail", using: :btree
  add_index "templates", ["uuid"], name: "ix_templates_uuid", using: :btree
  add_index "templates", ["uuid"], name: "templates_uuid_key", unique: true, using: :btree

  create_table "tenant_regions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "user_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenant_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_active"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "transaction_details", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pricing_plan_id"
    t.float    "amount"
    t.string   "transaction_id",   limit: 255
    t.string   "profile_id",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expiry_date"
    t.string   "order_id",         limit: 255
    t.boolean  "active",                       default: false
    t.string   "action",           limit: 255
    t.string   "payment_status",   limit: 255
    t.text     "zaakpay_response"
    t.string   "response_dec",     limit: 255
    t.integer  "response_code"
    t.string   "tracking_id",      limit: 255
    t.string   "bank_ref_no",      limit: 255
    t.string   "failure_message",  limit: 255
    t.string   "payment_mode",     limit: 255
    t.string   "card_name",        limit: 255
    t.integer  "status_code"
    t.string   "status_message",   limit: 255
    t.string   "currency",         limit: 255
    t.integer  "request_plan_id"
  end

  add_index "transaction_details", ["order_id"], name: "index_transaction_details_on_order_id", using: :btree
  add_index "transaction_details", ["pricing_plan_id"], name: "index_transaction_details_on_pricing_plan_id", using: :btree
  add_index "transaction_details", ["profile_id"], name: "index_transaction_details_on_profile_id", using: :btree
  add_index "transaction_details", ["transaction_id"], name: "index_transaction_details_on_transaction_id", using: :btree
  add_index "transaction_details", ["user_id"], name: "index_transaction_details_on_user_id", using: :btree

  create_table "user_action_lists", force: :cascade do |t|
    t.boolean  "completed"
    t.integer  "user_id"
    t.integer  "action_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_channels", force: :cascade do |t|
    t.text     "channel_type"
    t.integer  "channel_id"
    t.integer  "share_medium_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_channels", ["channel_id"], name: "index_user_channels_on_channel_id", using: :btree
  add_index "user_channels", ["share_medium_id"], name: "index_user_channels_on_share_medium_id", using: :btree

  create_table "user_configs", force: :cascade do |t|
    t.text     "engage"
    t.text     "listen"
    t.text     "others"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_invites", force: :cascade do |t|
    t.string  "email",        limit: 255
    t.integer "user_id"
    t.boolean "is_onboarded"
  end

  create_table "user_library", force: :cascade do |t|
    t.integer  "user_id",               null: false
    t.string   "name",      limit: 255, null: false
    t.string   "type",      limit: 255, null: false
    t.text     "url"
    t.text     "thumbnail"
    t.datetime "added_on",              null: false
  end

  add_index "user_library", ["name"], name: "ix_user_library_name", using: :btree
  add_index "user_library", ["type"], name: "ix_user_library_type", using: :btree
  add_index "user_library", ["user_id", "name"], name: "user_library_user_id_name_key", unique: true, using: :btree
  add_index "user_library", ["user_id"], name: "ix_user_library_user_id", using: :btree

  create_table "user_location_channels", force: :cascade do |t|
    t.integer  "channel_id"
    t.string   "channel_type", limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_location_channels", ["channel_id", "channel_type"], name: "index_user_location_channels_on_channel_id_and_channel_type", using: :btree

  create_table "user_mobile_channels", force: :cascade do |t|
    t.string   "channel",          limit: 255
    t.integer  "contact_group_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_mobile_channels", ["contact_group_id"], name: "index_user_mobile_channels_on_contact_group_id", using: :btree

  create_table "user_social_channels", force: :cascade do |t|
    t.string   "channel",       limit: 255
    t.text     "social_id"
    t.text     "social_token"
    t.string   "email",         limit: 255
    t.text     "name"
    t.text     "profile_image"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "connections"
    t.boolean  "valid_oauth"
    t.boolean  "is_page"
    t.integer  "admin_id"
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
