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

ActiveRecord::Schema.define(version: 2023_01_11_173124) do

  create_table "AspNetRoleClaims", primary_key: "Id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "RoleId", null: false
    t.text "ClaimType", limit: 4294967295
    t.text "ClaimValue", limit: 4294967295
    t.index ["RoleId"], name: "IX_AspNetRoleClaims_RoleId"
  end

  create_table "AspNetRoles", primary_key: "Id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "Name", limit: 256
    t.string "NormalizedName", limit: 256
    t.text "ConcurrencyStamp", limit: 4294967295
    t.index ["NormalizedName"], name: "RoleNameIndex", unique: true
  end

  create_table "AspNetUserClaims", primary_key: "Id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "UserId", null: false
    t.text "ClaimType", limit: 4294967295
    t.text "ClaimValue", limit: 4294967295
    t.index ["UserId"], name: "IX_AspNetUserClaims_UserId"
  end

  create_table "AspNetUserLogins", primary_key: ["LoginProvider", "ProviderKey"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "LoginProvider", limit: 128, null: false
    t.string "ProviderKey", limit: 128, null: false
    t.text "ProviderDisplayName", limit: 4294967295
    t.string "UserId", null: false
    t.index ["UserId"], name: "IX_AspNetUserLogins_UserId"
  end

  create_table "AspNetUserRoles", primary_key: ["UserId", "RoleId"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "UserId", null: false
    t.string "RoleId", null: false
    t.index ["RoleId"], name: "IX_AspNetUserRoles_RoleId"
  end

  create_table "AspNetUserTokens", primary_key: ["UserId", "LoginProvider", "Name"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "UserId", null: false
    t.string "LoginProvider", limit: 128, null: false
    t.string "Name", limit: 128, null: false
    t.text "Value", limit: 4294967295
  end

  create_table "AspNetUsers", primary_key: "Id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "UserName", limit: 256
    t.string "NormalizedUserName", limit: 256
    t.string "Email", limit: 256
    t.string "NormalizedEmail", limit: 256
    t.boolean "EmailConfirmed", null: false
    t.text "PasswordHash", limit: 4294967295
    t.text "SecurityStamp", limit: 4294967295
    t.text "ConcurrencyStamp", limit: 4294967295
    t.text "PhoneNumber", limit: 4294967295
    t.boolean "PhoneNumberConfirmed", null: false
    t.boolean "TwoFactorEnabled", null: false
    t.datetime "LockoutEnd", precision: 6
    t.boolean "LockoutEnabled", null: false
    t.integer "AccessFailedCount", null: false
    t.index ["NormalizedEmail"], name: "EmailIndex"
    t.index ["NormalizedUserName"], name: "UserNameIndex", unique: true
  end

  create_table "__EFMigrationsHistory", primary_key: "MigrationId", id: :string, limit: 150, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "ProductVersion", limit: 32, null: false
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "address_type"
    t.string "status"
    t.string "entity"
    t.string "number_and_street"
    t.string "suite_appartment"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
  end

  create_table "batteries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "type_of_building"
    t.string "status"
    t.date "date_of_commissioning"
    t.date "date_of_last_inspection"
    t.text "certificate_of_operations"
    t.string "information"
    t.string "notes"
    t.bigint "building_id"
    t.bigint "employee_id"
    t.index ["building_id"], name: "index_batteries_on_building_id"
    t.index ["employee_id"], name: "index_batteries_on_employee_id"
  end

  create_table "building_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.bigint "building_id"
    t.index ["building_id"], name: "index_building_details_on_building_id"
  end

  create_table "buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "buildingAddress"
    t.string "adminFullName"
    t.string "adminEmail"
    t.string "adminPhoneNumber"
    t.string "technicalContactFullName"
    t.string "technicalContactEmail"
    t.string "technicalContactPhoneNumber"
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_buildings_on_customer_id"
  end

  create_table "columns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "number_floors_served"
    t.string "status"
    t.string "information"
    t.text "notes"
    t.bigint "battery_id"
    t.string "building_type"
    t.index ["battery_id"], name: "index_columns_on_battery_id"
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "customers_creation_date"
    t.string "company_name"
    t.string "Company_headquarters_address"
    t.string "fullname_company_contact"
    t.string "company_contact_phone"
    t.string "email_company_contact"
    t.string "Company_description"
    t.string "fullname_service_technical_authority"
    t.string "technical_authority_phone_service"
    t.string "technical_manager"
    t.string "_email_service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_customers_on_address_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "elevators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "serial_number"
    t.string "model"
    t.string "status"
    t.date "date_commissioning"
    t.date "date_last_inspection"
    t.string "certificate_inspection"
    t.string "information"
    t.text "notes"
    t.bigint "column_id"
    t.string "building_type"
    t.index ["column_id"], name: "index_elevators_on_column_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "title"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.json "facial_rec"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "interventions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "author", null: false
    t.integer "customerId", null: false
    t.integer "buildingId", null: false
    t.integer "batteryId", null: false
    t.integer "columnId"
    t.integer "elevatorId"
    t.integer "employeeId"
    t.timestamp "interventionStartAt"
    t.timestamp "interventionEndAt"
    t.string "result", default: "Incomplete", null: false
    t.text "report"
    t.string "status", default: "Pending", null: false
  end

  create_table "leads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "full_name_contact"
    t.string "company_name"
    t.string "email"
    t.string "phone"
    t.string "project_name"
    t.text "project_description"
    t.string "department_elevator"
    t.text "message"
    t.datetime "date_contact_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name_company"
    t.string "email_company"
    t.string "building_type"
    t.string "number_apartments"
    t.string "number_floors_residential"
    t.string "number_basements_residential"
    t.string "number_distinct_businesses_commercial"
    t.string "number_floors_commercial"
    t.string "number_basements_commercial"
    t.string "number_parking_commercial"
    t.string "number_elevators"
    t.string "number_separate_companies"
    t.string "number_floors_corporate"
    t.string "number_basements_corporate"
    t.string "number_parking_corporate"
    t.string "max_number_occupants_floor_corporate"
    t.string "number_distinct_businesses_hybrid"
    t.string "number_floors_hybrid"
    t.string "number_basements_hybrid"
    t.string "number_parking_hybrid"
    t.string "max_number_occupants_floor_hybrid"
    t.string "number_hours_activity"
    t.string "product_line"
    t.integer "elevator_need"
    t.string "unit_price"
    t.string "total_price"
    t.string "installation_fees"
    t.string "final_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_email"
    t.string "company_name"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "AspNetRoleClaims", "AspNetRoles", column: "RoleId", primary_key: "Id", name: "FK_AspNetRoleClaims_AspNetRoles_RoleId", on_delete: :cascade
  add_foreign_key "AspNetUserClaims", "AspNetUsers", column: "UserId", primary_key: "Id", name: "FK_AspNetUserClaims_AspNetUsers_UserId", on_delete: :cascade
  add_foreign_key "AspNetUserLogins", "AspNetUsers", column: "UserId", primary_key: "Id", name: "FK_AspNetUserLogins_AspNetUsers_UserId", on_delete: :cascade
  add_foreign_key "AspNetUserRoles", "AspNetRoles", column: "RoleId", primary_key: "Id", name: "FK_AspNetUserRoles_AspNetRoles_RoleId", on_delete: :cascade
  add_foreign_key "AspNetUserRoles", "AspNetUsers", column: "UserId", primary_key: "Id", name: "FK_AspNetUserRoles_AspNetUsers_UserId", on_delete: :cascade
  add_foreign_key "AspNetUserTokens", "AspNetUsers", column: "UserId", primary_key: "Id", name: "FK_AspNetUserTokens_AspNetUsers_UserId", on_delete: :cascade
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "batteries", "buildings"
  add_foreign_key "batteries", "employees"
  add_foreign_key "building_details", "buildings"
  add_foreign_key "buildings", "customers"
  add_foreign_key "columns", "batteries"
  add_foreign_key "customers", "addresses"
  add_foreign_key "customers", "users"
  add_foreign_key "elevators", "columns"
  add_foreign_key "employees", "users"
end
