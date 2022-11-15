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

ActiveRecord::Schema[7.0].define(version: 2022_11_06_205015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "api_requests", id: :serial, force: :cascade do |t|
    t.string "request"
    t.json "response"
    t.boolean "success"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "batch_id"
    t.float "response_time"
    t.string "requestable_type"
    t.bigint "requestable_id"
    t.string "service"
    t.integer "retries"
    t.index ["batch_id"], name: "index_api_requests_on_batch_id"
    t.index ["requestable_type", "requestable_id"], name: "index_api_requests_on_requestable_type_and_requestable_id"
  end

  create_table "buoy_reports", force: :cascade do |t|
    t.bigint "buoy_id", null: false
    t.datetime "timestamp", precision: nil, null: false
    t.decimal "ground_swell_height"
    t.decimal "ground_swell_period"
    t.decimal "ground_swell_direction"
    t.decimal "wind_swell_height"
    t.decimal "wind_swell_period"
    t.decimal "wind_swell_direction"
    t.string "steepness"
    t.decimal "sig_wave_height"
    t.decimal "avg_period"
    t.integer "mean_wave_direction"
    t.bigint "api_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_buoy_reports_on_api_request_id"
    t.index ["buoy_id"], name: "index_buoy_reports_on_buoy_id"
    t.index ["timestamp"], name: "index_buoy_reports_on_timestamp"
  end

  create_table "buoys", force: :cascade do |t|
    t.string "name", null: false
    t.float "lat", null: false
    t.float "lon", null: false
    t.integer "ndbc_id", null: false
    t.string "slug", null: false
    t.bigint "region_id", null: false
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ndbc_id"], name: "index_buoys_on_ndbc_id", unique: true
    t.index ["region_id", "slug"], name: "index_buoys_on_region_id_and_slug", unique: true
    t.index ["region_id", "sort_order", "lat", "lon"], name: "index_buoys_on_region_id_and_sort_order_and_lat_and_lon"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "msws", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp", precision: nil
    t.decimal "min_height"
    t.decimal "max_height"
    t.integer "rating"
    t.integer "wind_effect"
    t.integer "api_request_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["api_request_id"], name: "index_msws_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_msws_on_spot_id_and_timestamp"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "sort_order"
    t.string "timezone"
    t.index ["slug"], name: "index_regions_on_slug", unique: true
    t.index ["sort_order"], name: "index_regions_on_sort_order", unique: true
  end

  create_table "spitcast_v1s", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp", precision: nil
    t.decimal "height"
    t.string "rating"
    t.integer "api_request_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["api_request_id"], name: "index_spitcast_v1s_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_spitcast_v1s_on_spot_id_and_timestamp"
  end

  create_table "spitcast_v2s", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.datetime "timestamp", precision: nil, null: false
    t.decimal "height", null: false
    t.decimal "rating", null: false
    t.bigint "api_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_spitcast_v2s_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_spitcast_v2s_on_spot_id_and_timestamp"
  end

  create_table "spots", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lon"
    t.integer "surfline_v1_id"
    t.integer "msw_id"
    t.integer "spitcast_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
    t.bigint "subregion_id"
    t.string "spitcast_slug"
    t.integer "sort_order"
    t.string "surfline_v2_id"
    t.index ["msw_id", "surfline_v1_id", "surfline_v2_id", "spitcast_id"], name: "spots_unique_index", unique: true
    t.index ["subregion_id", "slug"], name: "index_spots_on_subregion_id_and_slug", unique: true
    t.index ["subregion_id", "sort_order"], name: "index_spots_on_subregion_id_and_sort_order", unique: true
  end

  create_table "subregions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "timezone"
    t.bigint "region_id"
    t.integer "sort_order"
    t.index ["region_id", "slug"], name: "index_subregions_on_region_id_and_slug", unique: true
    t.index ["region_id", "sort_order"], name: "index_subregions_on_region_id_and_sort_order", unique: true
  end

  create_table "surfline_conditions", force: :cascade do |t|
    t.date "forecast_day"
    t.float "rating"
    t.float "min_height"
    t.float "max_height"
    t.bigint "surfline_spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["surfline_spot_id"], name: "index_surfline_conditions_on_surfline_spot_id"
  end

  create_table "surfline_lolas", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp", precision: nil
    t.decimal "min_height"
    t.decimal "max_height"
    t.decimal "swell_rating"
    t.boolean "optimal_wind"
    t.integer "api_request_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["api_request_id"], name: "index_surfline_lolas_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_lolas_on_spot_id_and_timestamp"
  end

  create_table "surfline_nearshores", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp", precision: nil
    t.decimal "min_height"
    t.decimal "max_height"
    t.decimal "swell_rating"
    t.boolean "optimal_wind"
    t.integer "api_request_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["api_request_id"], name: "index_surfline_nearshores_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_nearshores_on_spot_id_and_timestamp"
  end

  create_table "surfline_spots", force: :cascade do |t|
    t.bigint "spot_id"
    t.float "lat"
    t.float "lon"
    t.string "name"
    t.string "surfline_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_surfline_spots_on_spot_id"
    t.index ["surfline_id"], name: "index_surfline_spots_on_surfline_id", unique: true
  end

  create_table "surfline_v2_lolas", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.datetime "timestamp", precision: nil
    t.decimal "min_height"
    t.decimal "max_height"
    t.integer "swell_rating"
    t.integer "wind_rating"
    t.bigint "api_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_surfline_v2_lolas_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_v2_lolas_on_spot_id_and_timestamp"
  end

  create_table "surfline_v2_lotus", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.datetime "timestamp", precision: nil
    t.decimal "min_height"
    t.decimal "max_height"
    t.integer "swell_rating"
    t.integer "wind_rating"
    t.bigint "api_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_surfline_v2_lotus_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_v2_lotus_on_spot_id_and_timestamp"
  end

  create_table "update_batches", force: :cascade do |t|
    t.integer "concurrency"
    t.interval "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["kind"], name: "index_update_batches_on_kind"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "water_qualities", id: :serial, force: :cascade do |t|
    t.integer "dept_id"
    t.string "site_id"
    t.datetime "timestamp", precision: nil
    t.string "name"
    t.boolean "ok"
    t.string "comments"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["dept_id", "site_id", "timestamp"], name: "index_water_qualities_on_dept_id_and_site_id_and_timestamp"
  end

  create_table "water_quality_departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "api_requests", "update_batches", column: "batch_id"
  add_foreign_key "buoy_reports", "api_requests"
  add_foreign_key "buoy_reports", "buoys"
  add_foreign_key "buoys", "regions"
  add_foreign_key "msws", "api_requests"
  add_foreign_key "msws", "spots"
  add_foreign_key "spitcast_v1s", "api_requests"
  add_foreign_key "spitcast_v1s", "spots"
  add_foreign_key "spitcast_v2s", "api_requests"
  add_foreign_key "spitcast_v2s", "spots"
  add_foreign_key "spots", "subregions"
  add_foreign_key "subregions", "regions"
  add_foreign_key "surfline_lolas", "api_requests"
  add_foreign_key "surfline_lolas", "spots"
  add_foreign_key "surfline_nearshores", "api_requests"
  add_foreign_key "surfline_nearshores", "spots"
  add_foreign_key "surfline_spots", "spots"
  add_foreign_key "surfline_v2_lolas", "api_requests"
  add_foreign_key "surfline_v2_lolas", "spots"
  add_foreign_key "surfline_v2_lotus", "api_requests"
  add_foreign_key "surfline_v2_lotus", "spots"
  add_foreign_key "water_qualities", "water_quality_departments", column: "dept_id"
end
