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

ActiveRecord::Schema[7.0].define(version: 2025_10_17_094659) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "posts", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "idx_posts_created_at"
    t.index ["status"], name: "index_posts_on_status"
    t.index ["user_id"], name: "idx_posts_user_id"
  end

  create_table "posts_backup_1760084713", id: :bigint, default: -> { "nextval('posts_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "user_partition", default: 0
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_user_partition_0", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_0_created_at_idx"
    t.index ["status"], name: "posts_user_partition_0_status_idx"
    t.index ["user_id"], name: "posts_user_partition_0_user_id_idx"
  end

  create_table "posts_user_partition_1", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_1_created_at_idx"
    t.index ["status"], name: "posts_user_partition_1_status_idx"
    t.index ["user_id"], name: "posts_user_partition_1_user_id_idx"
  end

  create_table "posts_user_partition_10", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_10_created_at_idx"
    t.index ["status"], name: "posts_user_partition_10_status_idx"
    t.index ["user_id"], name: "posts_user_partition_10_user_id_idx"
  end

  create_table "posts_user_partition_11", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_11_created_at_idx"
    t.index ["status"], name: "posts_user_partition_11_status_idx"
    t.index ["user_id"], name: "posts_user_partition_11_user_id_idx"
  end

  create_table "posts_user_partition_12", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_12_created_at_idx"
    t.index ["status"], name: "posts_user_partition_12_status_idx"
    t.index ["user_id"], name: "posts_user_partition_12_user_id_idx"
  end

  create_table "posts_user_partition_13", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_13_created_at_idx"
    t.index ["status"], name: "posts_user_partition_13_status_idx"
    t.index ["user_id"], name: "posts_user_partition_13_user_id_idx"
  end

  create_table "posts_user_partition_14", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_14_created_at_idx"
    t.index ["status"], name: "posts_user_partition_14_status_idx"
    t.index ["user_id"], name: "posts_user_partition_14_user_id_idx"
  end

  create_table "posts_user_partition_15", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_15_created_at_idx"
    t.index ["status"], name: "posts_user_partition_15_status_idx"
    t.index ["user_id"], name: "posts_user_partition_15_user_id_idx"
  end

  create_table "posts_user_partition_2", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_2_created_at_idx"
    t.index ["status"], name: "posts_user_partition_2_status_idx"
    t.index ["user_id"], name: "posts_user_partition_2_user_id_idx"
  end

  create_table "posts_user_partition_3", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_3_created_at_idx"
    t.index ["status"], name: "posts_user_partition_3_status_idx"
    t.index ["user_id"], name: "posts_user_partition_3_user_id_idx"
  end

  create_table "posts_user_partition_4", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_4_created_at_idx"
    t.index ["status"], name: "posts_user_partition_4_status_idx"
    t.index ["user_id"], name: "posts_user_partition_4_user_id_idx"
  end

  create_table "posts_user_partition_5", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_5_created_at_idx"
    t.index ["status"], name: "posts_user_partition_5_status_idx"
    t.index ["user_id"], name: "posts_user_partition_5_user_id_idx"
  end

  create_table "posts_user_partition_6", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_6_created_at_idx"
    t.index ["status"], name: "posts_user_partition_6_status_idx"
    t.index ["user_id"], name: "posts_user_partition_6_user_id_idx"
  end

  create_table "posts_user_partition_7", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_7_created_at_idx"
    t.index ["status"], name: "posts_user_partition_7_status_idx"
    t.index ["user_id"], name: "posts_user_partition_7_user_id_idx"
  end

  create_table "posts_user_partition_8", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_8_created_at_idx"
    t.index ["status"], name: "posts_user_partition_8_status_idx"
    t.index ["user_id"], name: "posts_user_partition_8_user_id_idx"
  end

  create_table "posts_user_partition_9", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('posts_partitioned_new_id_seq'::regclass)" }, null: false
    t.string "title", limit: 255, null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "now()" }, null: false
    t.integer "user_partition", null: false
    t.string "status", default: "draft", null: false
    t.index ["created_at"], name: "posts_user_partition_9_created_at_idx"
    t.index ["status"], name: "posts_user_partition_9_status_idx"
    t.index ["user_id"], name: "posts_user_partition_9_user_id_idx"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "posts_backup_1760084713", column: "post_id"
  add_foreign_key "comments", "users"
  add_foreign_key "posts_backup_1760084713", "users"
end
