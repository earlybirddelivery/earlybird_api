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

ActiveRecord::Schema[7.1].define(version: 2025_06_26_130725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "address_details", force: :cascade do |t|
    t.string "full_name"
    t.string "door_no"
    t.string "mobile_number"
    t.string "delivery_line_1"
    t.string "delivery_line_2"
    t.string "area"
    t.string "city"
    t.string "district"
    t.string "state"
    t.integer "pincode"
    t.string "land_mark"
    t.string "address_type"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.boolean "primary", default: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["addressable_type", "addressable_id"], name: "index_address_details_on_addressable_type_and_addressable_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.integer "discount"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_type"
    t.text "description"
    t.boolean "active", default: true
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "deleted_at", precision: nil
    t.integer "deleted_by_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "day_of_month", null: false
    t.string "day_of_week", null: false
    t.integer "quarter", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.bigint "product_variant_id"
    t.bigint "product_variant_version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.integer "count"
    t.decimal "cost"
    t.string "cart_item_type"
    t.integer "quantity_per_day", default: 1
    t.integer "total_quantity"
    t.date "subscription_start_date"
    t.date "subscription_end_date"
    t.string "subscription_type"
    t.bigint "subscriber_id"
    t.integer "created_by"
    t.integer "updated_by"
    t.boolean "trail_pack", default: false
    t.integer "trail_days"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["product_variant_id"], name: "index_cart_items_on_product_variant_id"
    t.index ["product_variant_version_id"], name: "index_cart_items_on_product_variant_version_id"
    t.index ["subscriber_id"], name: "index_cart_items_on_subscriber_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "customer_id"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "crm_customer_mappings", force: :cascade do |t|
    t.bigint "crm_id", null: false
    t.bigint "customer_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active", default: false
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crm_id"], name: "crm"
    t.index ["customer_id"], name: "index_crm_customer_mappings_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_number", null: false
    t.string "email"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "dashboard_tiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "page_name", null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dashboard_tiles_on_name"
  end

  create_table "day_patterns", force: :cascade do |t|
    t.string "selector_type"
    t.bigint "selector_id"
    t.integer "days_gap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["selector_type", "selector_id"], name: "index_day_patterns_on_selector_type_and_selector_id"
  end

  create_table "dealers", force: :cascade do |t|
    t.string "name"
    t.string "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "delivery_boys", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_number", null: false
    t.string "email"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "delivery_tasks", force: :cascade do |t|
    t.bigint "delivery_boy_id"
    t.decimal "total_bill", default: "0.0"
    t.string "shift"
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.string "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dealer_id"
    t.string "status", default: "Created"
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["dealer_id"], name: "index_delivery_tasks_on_dealer_id"
    t.index ["delivery_boy_id"], name: "index_delivery_tasks_on_delivery_boy_id"
  end

  create_table "fcm_registration_ids", force: :cascade do |t|
    t.bigint "user_id"
    t.string "registration_id"
    t.string "device_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["user_id"], name: "index_fcm_registration_ids_on_user_id"
  end

  create_table "fcm_topic_registrations", force: :cascade do |t|
    t.bigint "fcm_topic_id"
    t.bigint "fcm_registration_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["fcm_registration_id_id"], name: "index_fcm_topic_registrations_on_fcm_registration_id_id"
    t.index ["fcm_topic_id"], name: "index_fcm_topic_registrations_on_fcm_topic_id"
  end

  create_table "fcm_topics", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.bigint "address_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["address_detail_id"], name: "index_locations_on_address_detail_id"
  end

  create_table "manual_notifications", force: :cascade do |t|
    t.string "title"
    t.string "message"
    t.bigint "fcm_topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "click_action"
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["fcm_topic_id"], name: "index_manual_notifications_on_fcm_topic_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "revoked_at", precision: nil
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.bigint "product_variant_id"
    t.integer "count", default: 1
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_variant_version_id"
    t.decimal "cost"
    t.integer "quantity_per_day", default: 1
    t.integer "total_quantity"
    t.date "subscription_start_date"
    t.date "subscription_end_date"
    t.string "subscription_type"
    t.bigint "subscriber_id"
    t.integer "created_by"
    t.integer "updated_by"
    t.date "pause_until"
    t.integer "trail_days"
    t.boolean "trail_pack", default: false
    t.integer "delivered_count", default: 0
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["product_variant_id"], name: "index_order_items_on_product_variant_id"
    t.index ["product_variant_version_id"], name: "index_order_items_on_product_variant_version_id"
    t.index ["subscriber_id"], name: "index_order_items_on_subscriber_id"
  end

  create_table "order_razor_pay_informations", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "razorpay_order_id", null: false
    t.string "entity"
    t.integer "amount"
    t.integer "amount_paid"
    t.integer "amount_due"
    t.string "currency"
    t.string "receipt"
    t.string "offer_id"
    t.string "status"
    t.integer "attempts"
    t.string "notes", default: [], array: true
    t.bigint "razor_pay_created_at"
    t.string "razorpay_payment_id"
    t.string "razorpay_signature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["order_id"], name: "index_order_razor_pay_informations_on_order_id"
  end

  create_table "order_reviews", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "rating"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["order_id"], name: "index_order_reviews_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "delivery_boy_id"
    t.bigint "customer_id"
    t.string "status", default: "Created"
    t.string "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_detail_id"
    t.decimal "total_bill"
    t.date "date_of_order"
    t.string "orderid"
    t.integer "cgst"
    t.integer "sgst"
    t.decimal "bill"
    t.decimal "delivery_fee"
    t.string "razorpay_order_id"
    t.integer "razor_pay_amount"
    t.string "razor_pay_status"
    t.string "razorpay_payment_id"
    t.string "razorpay_signature"
    t.string "payment_method"
    t.integer "gst"
    t.json "razor_pay_repsonse"
    t.integer "amount_paid"
    t.string "admin_status", default: "Created"
    t.boolean "packed", default: false
    t.date "delivery_date"
    t.integer "total_items"
    t.bigint "delivery_task_id"
    t.boolean "amount_paid_offline", default: false
    t.text "failed_reason"
    t.boolean "picked", default: false
    t.string "order_type"
    t.integer "created_by"
    t.integer "updated_by"
    t.string "cancel_reason"
    t.string "issue_description"
    t.bigint "parent_id"
    t.bigint "crm_id"
    t.text "payment_notes"
    t.index ["address_detail_id"], name: "index_orders_on_address_detail_id"
    t.index ["crm_id"], name: "index_orders_on_crm_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["delivery_boy_id"], name: "index_orders_on_delivery_boy_id"
    t.index ["delivery_task_id"], name: "index_orders_on_delivery_task_id"
    t.index ["orderid"], name: "index_orders_on_orderid"
    t.index ["parent_id"], name: "index_orders_on_parent_id"
  end

  create_table "posters", force: :cascade do |t|
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "product_variant_versions", force: :cascade do |t|
    t.bigint "product_variant_id"
    t.decimal "price"
    t.integer "version", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", default: "0.0"
    t.decimal "final_price"
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["product_variant_id"], name: "index_product_variant_versions_on_product_variant_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.bigint "product_id"
    t.string "variant_type"
    t.decimal "price"
    t.decimal "discount"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quantity"
    t.integer "current_product_variant_version"
    t.decimal "final_price"
    t.bigint "current_product_variant_version_id"
    t.integer "created_by"
    t.integer "updated_by"
    t.boolean "active", default: false
    t.integer "stock"
    t.integer "out_of_stock"
    t.datetime "deleted_at", precision: nil
    t.integer "deleted_by_id"
    t.index ["current_product_variant_version_id"], name: "index_product_variants_on_current_product_variant_version_id"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.integer "priority"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "best_selling"
    t.boolean "in_exclusive_offer"
    t.boolean "out_of_stock", default: false
    t.boolean "coming_soon", default: false
    t.string "description"
    t.boolean "subscribable", default: false
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "deleted_at", precision: nil
    t.integer "deleted_by_id"
    t.boolean "available_as_trail_pack", default: false
    t.boolean "available_for_one_time_delivery", default: true
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "published_notifications", force: :cascade do |t|
    t.bigint "manual_notification_id"
    t.bigint "fcm_topic_id"
    t.string "response_body"
    t.integer "response_code"
    t.integer "registration_ids"
    t.bigint "user_id"
    t.date "published_date"
    t.time "published_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["fcm_topic_id"], name: "index_published_notifications_on_fcm_topic_id"
    t.index ["manual_notification_id"], name: "index_published_notifications_on_manual_notification_id"
    t.index ["user_id"], name: "index_published_notifications_on_user_id"
  end

  create_table "quantity_patterns", force: :cascade do |t|
    t.string "selector_type"
    t.bigint "selector_id"
    t.integer "day1_quantity"
    t.integer "day2_quantity"
    t.integer "day3_quantity"
    t.integer "day4_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["selector_type", "selector_id"], name: "index_quantity_patterns_on_selector_type_and_selector_id"
  end

  create_table "razorpay_payments", force: :cascade do |t|
    t.bigint "order_razor_pay_information_id"
    t.string "payment_id"
    t.string "entity"
    t.integer "amount"
    t.string "currency"
    t.string "payment_status"
    t.string "invoice_id"
    t.boolean "international"
    t.string "method"
    t.integer "amount_refunded"
    t.string "refund_status"
    t.boolean "captured"
    t.string "description"
    t.string "card_id"
    t.string "bank"
    t.string "wallet"
    t.string "vpa"
    t.string "email"
    t.string "contact"
    t.string "notes", array: true
    t.integer "fee"
    t.integer "tax"
    t.string "error_code"
    t.string "error_description"
    t.string "error_source"
    t.string "error_step"
    t.string "error_reason"
    t.json "acquirer_data"
    t.string "payment_initiated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["order_razor_pay_information_id"], name: "index_razorpay_payments_on_order_razor_pay_information_id"
  end

  create_table "reference_data", force: :cascade do |t|
    t.string "data_type", null: false
    t.string "key", null: false
    t.string "label", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order", default: 1
    t.string "short_key"
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["data_type"], name: "index_reference_data_on_data_type"
    t.index ["key"], name: "index_reference_data_on_key", unique: true
  end

  create_table "referrals", force: :cascade do |t|
    t.string "referal_code"
    t.bigint "referred_user_id", null: false
    t.bigint "referrer_id", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referred_user_id"], name: "referred_user"
    t.index ["referrer_id"], name: "referrer"
  end

  create_table "role_dashboard_tiles", force: :cascade do |t|
    t.bigint "dashboard_tile_id"
    t.string "role", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_tile_id"], name: "index_role_dashboard_tiles_on_dashboard_tile_id"
  end

  create_table "user_favourite_products", force: :cascade do |t|
    t.bigint "favourite_product_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["favourite_product_id"], name: "favourite_product"
    t.index ["user_id"], name: "index_user_favourite_products_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "mobile_number", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.integer "otp"
    t.bigint "delivery_boy_id"
    t.datetime "otp_expiry_time", precision: nil
    t.boolean "confirmed"
    t.string "notification_key_name"
    t.string "notification_key"
    t.integer "created_by"
    t.integer "updated_by"
    t.string "referal_code"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["delivery_boy_id"], name: "index_users_on_delivery_boy_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "variant_type"
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "week_patterns", force: :cascade do |t|
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.string "selector_type"
    t.bigint "selector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.string "week_days", default: [], array: true
    t.index ["selector_type", "selector_id"], name: "index_week_patterns_on_selector_type_and_selector_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "product_variant_versions"
  add_foreign_key "cart_items", "product_variants"
  add_foreign_key "cart_items", "products"
  add_foreign_key "cart_items", "users", column: "subscriber_id"
  add_foreign_key "carts", "customers"
  add_foreign_key "crm_customer_mappings", "customers"
  add_foreign_key "crm_customer_mappings", "users", column: "crm_id"
  add_foreign_key "delivery_tasks", "dealers"
  add_foreign_key "delivery_tasks", "delivery_boys"
  add_foreign_key "fcm_registration_ids", "users"
  add_foreign_key "fcm_topic_registrations", "fcm_registration_ids"
  add_foreign_key "fcm_topic_registrations", "fcm_topics"
  add_foreign_key "locations", "address_details"
  add_foreign_key "manual_notifications", "fcm_topics"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id", name: "fk_oauth_access_grants_users"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id", name: "fk_oauth_access_tokens_users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_variant_versions"
  add_foreign_key "order_items", "product_variants"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_items", "users", column: "subscriber_id"
  add_foreign_key "order_razor_pay_informations", "orders"
  add_foreign_key "order_reviews", "orders"
  add_foreign_key "orders", "address_details"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "delivery_boys"
  add_foreign_key "orders", "delivery_tasks"
  add_foreign_key "orders", "orders", column: "parent_id"
  add_foreign_key "orders", "users", column: "crm_id"
  add_foreign_key "product_variant_versions", "product_variants"
  add_foreign_key "product_variants", "product_variant_versions", column: "current_product_variant_version_id"
  add_foreign_key "product_variants", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "published_notifications", "fcm_topics"
  add_foreign_key "published_notifications", "manual_notifications"
  add_foreign_key "published_notifications", "users"
  add_foreign_key "razorpay_payments", "order_razor_pay_informations"
  add_foreign_key "referrals", "users", column: "referred_user_id"
  add_foreign_key "referrals", "users", column: "referrer_id"
  add_foreign_key "role_dashboard_tiles", "dashboard_tiles"
  add_foreign_key "user_favourite_products", "products", column: "favourite_product_id"
  add_foreign_key "user_favourite_products", "users"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "customers"
  add_foreign_key "users", "delivery_boys"
end
