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

ActiveRecord::Schema.define(version: 20150513222056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "alerts", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "staff_id"
    t.string   "status",        limit: 20
    t.text     "message"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_item_id"
  end

  add_index "alerts", ["end_date"], name: "index_alerts_on_end_date", using: :btree
  add_index "alerts", ["order_item_id"], name: "index_order_item_id", using: :btree
  add_index "alerts", ["start_date"], name: "index_alerts_on_start_date", using: :btree

  create_table "api_tokens", force: :cascade do |t|
    t.integer  "staff_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "api_tokens", ["staff_id"], name: "index_api_tokens_on_staff_id", using: :btree

  create_table "approvals", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "project_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
  end

  add_index "approvals", ["project_id"], name: "index_approvals_on_project_id", using: :btree
  add_index "approvals", ["staff_id"], name: "index_approvals_on_staff_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "staff_id"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
  add_index "authentications", ["staff_id"], name: "index_authentications_on_staff_id", using: :btree

  create_table "bundled_products", force: :cascade do |t|
    t.integer  "bundle_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bundled_products", ["bundle_id"], name: "index_bundled_products_on_bundle_id", using: :btree
  add_index "bundled_products", ["product_id"], name: "index_bundled_products_on_product_id", using: :btree

  create_table "bundles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "img"
    t.datetime "active_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "count"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["staff_id"], name: "index_carts_on_staff_id", using: :btree

  create_table "chargebacks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cloud_id"
    t.decimal  "hourly_price", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "chargebacks", ["cloud_id"], name: "index_chargebacks_on_cloud_id", using: :btree
  add_index "chargebacks", ["deleted_at"], name: "index_chargebacks_on_deleted_at", using: :btree
  add_index "chargebacks", ["product_id"], name: "index_chargebacks_on_product_id", using: :btree

  create_table "clouds", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra"
    t.datetime "deleted_at"
  end

  add_index "clouds", ["deleted_at"], name: "index_clouds_on_deleted_at", using: :btree

  create_table "content_pages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "staff_id"
    t.string   "slug",       null: false
    t.string   "title",      null: false
    t.text     "body"
  end

  add_index "content_pages", ["slug"], name: "index_content_pages_on_slug", unique: true, using: :btree
  add_index "content_pages", ["staff_id"], name: "index_content_pages_on_staff_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "role_id"
  end

  create_table "groups_staff", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "staff_id"
  end

  add_index "groups_staff", ["group_id"], name: "index_groups_staff_on_group_id", using: :btree
  add_index "groups_staff", ["staff_id"], name: "index_groups_staff_on_staff_id", using: :btree

  create_table "jellyfish_manageiq_big_data_products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cloud_provider"
    t.string   "chef_role"
    t.integer  "service_catalog_id"
    t.integer  "service_template_id"
    t.integer  "cpu_count"
    t.float    "disk_size"
    t.float    "ram_size"
  end

  create_table "jellyfish_manageiq_database_products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cloud_provider"
    t.string   "chef_role"
    t.integer  "service_catalog_id"
    t.integer  "service_template_id"
    t.string   "db_instance_class"
    t.string   "engine"
    t.float    "allocated_storage"
    t.string   "storage_type"
    t.string   "availability"
  end

  create_table "jellyfish_manageiq_infrastructure_products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cloud_provider"
    t.string   "chef_role"
    t.integer  "service_catalog_id"
    t.integer  "service_template_id"
    t.string   "instance_size"
    t.float    "disk_size"
  end

  create_table "jellyfish_manageiq_storage_products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cloud_provider"
    t.string   "chef_role"
    t.integer  "service_catalog_id"
    t.integer  "service_template_id"
    t.string   "availability"
    t.string   "region"
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "staff_id",   null: false
    t.integer  "level"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["staff_id"], name: "index_logs_on_staff_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "project_id"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["project_id"], name: "index_memberships_on_project_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.text     "text"
    t.text     "ago"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["staff_id"], name: "index_notifications_on_staff_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "cloud_id"
    t.integer  "product_id"
    t.integer  "service_id"
    t.integer  "provision_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "project_id"
    t.integer  "miq_id"
    t.uuid     "uuid",                                             default: "uuid_generate_v4()"
    t.decimal  "setup_price",             precision: 10, scale: 4, default: 0.0
    t.decimal  "hourly_price",            precision: 10, scale: 4, default: 0.0
    t.decimal  "monthly_price",           precision: 10, scale: 4, default: 0.0
    t.jsonb    "payload_request"
    t.jsonb    "payload_acknowledgement"
    t.jsonb    "payload_response"
    t.integer  "latest_alert_id"
    t.string   "status_msg"
  end

  add_index "order_items", ["cloud_id"], name: "index_order_items_on_cloud_id", using: :btree
  add_index "order_items", ["deleted_at"], name: "index_order_items_on_deleted_at", using: :btree
  add_index "order_items", ["miq_id"], name: "index_order_items_on_miq_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree
  add_index "order_items", ["service_id"], name: "index_order_items_on_service_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "staff_id",                      null: false
    t.text     "engine_response"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.jsonb    "options"
    t.datetime "deleted_at"
    t.float    "total",           default: 0.0
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["staff_id"], name: "index_orders_on_staff_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "img",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "organizations", ["deleted_at"], name: "index_organizations_on_deleted_at", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "questions_form_schema"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.text     "description"
    t.boolean  "active"
    t.string   "img",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.decimal  "setup_price",                      precision: 10, scale: 4, default: 0.0
    t.decimal  "hourly_price",                     precision: 10, scale: 4, default: 0.0
    t.decimal  "monthly_price",                    precision: 10, scale: 4, default: 0.0
    t.jsonb    "provisioning_answers"
    t.string   "product_type"
  end

  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree

  create_table "project_answers", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "project_question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_answers", ["project_id"], name: "index_project_answers_on_project_id", using: :btree
  add_index "project_answers", ["project_question_id"], name: "index_project_answers_on_project_question_id", using: :btree

  create_table "project_details", force: :cascade do |t|
    t.string  "requestor_name"
    t.date    "requestor_date"
    t.string  "team_name"
    t.integer "charge_number"
    t.float   "nte_budget"
    t.string  "project_owner"
    t.string  "sr_associate"
    t.string  "principal"
    t.date    "estimated_termination_date"
    t.string  "data_type"
    t.string  "others"
    t.integer "project_id"
  end

  add_index "project_details", ["project_id"], name: "index_project_details_on_project_id", using: :btree

  create_table "project_questions", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.string   "help_text",  limit: 255
    t.boolean  "required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "load_order"
    t.jsonb    "options"
    t.integer  "field_type",             default: 0
  end

  add_index "project_questions", ["deleted_at"], name: "index_project_questions_on_deleted_at", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "cc",          limit: 10
    t.string   "staff_id",    limit: 255
    t.string   "img",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "status",                                           default: 0
    t.integer  "approval",                                         default: 0
    t.datetime "archived"
    t.decimal  "spent",                   precision: 12, scale: 2, default: 0.0
    t.decimal  "budget",                  precision: 12, scale: 2, default: 0.0
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "projects", ["archived"], name: "index_projects_on_archived", using: :btree
  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.jsonb  "permissions"
  end

  create_table "staff", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255
    t.string   "phone",                  limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role",                               default: 0
    t.datetime "deleted_at"
    t.string   "authentication_token"
  end

  add_index "staff", ["authentication_token"], name: "index_staff_on_authentication_token", unique: true, using: :btree
  add_index "staff", ["deleted_at"], name: "index_staff_on_deleted_at", using: :btree
  add_index "staff", ["email"], name: "index_staff_on_email", unique: true, using: :btree
  add_index "staff", ["reset_password_token"], name: "index_staff_on_reset_password_token", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_setting_options", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.string   "field_type", limit: 100
    t.string   "help_text",  limit: 255
    t.text     "options"
    t.boolean  "required",               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_setting_options", ["deleted_at"], name: "index_user_setting_options_on_deleted_at", using: :btree
  add_index "user_setting_options", ["label"], name: "index_user_setting_options_on_label", unique: true, using: :btree

  create_table "user_settings", force: :cascade do |t|
    t.integer  "staff_id"
    t.string   "name",       limit: 255
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_settings", ["deleted_at"], name: "index_user_settings_on_deleted_at", using: :btree
  add_index "user_settings", ["staff_id", "name"], name: "index_user_settings_on_staff_id_and_name", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "wizard_answers", force: :cascade do |t|
    t.integer  "wizard_question_id"
    t.string   "text"
    t.string   "tags_to_add",        default: [],              array: true
    t.string   "tags_to_remove",     default: [],              array: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "wizard_answers", ["wizard_question_id"], name: "index_wizard_answers_on_wizard_question_id", using: :btree

  create_table "wizard_questions", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "api_tokens", "staff"
  add_foreign_key "groups_staff", "groups", on_delete: :cascade
  add_foreign_key "groups_staff", "staff", on_delete: :cascade
  add_foreign_key "memberships", "groups", on_delete: :cascade
  add_foreign_key "memberships", "projects", on_delete: :cascade
  add_foreign_key "wizard_answers", "wizard_questions", on_delete: :cascade
end
