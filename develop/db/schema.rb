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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131117053248) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "job_post_id"
    t.integer  "post_id"
    t.boolean  "anomynous_flag", :default => false
    t.boolean  "delete_flag",    :default => false
    t.string   "content",                           :null => false
    t.integer  "vote_up",        :default => 0
    t.integer  "vote_down",      :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "job_posts", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.string   "each",                             :null => false
    t.string   "hour",                             :null => false
    t.string   "name",                             :null => false
    t.string   "address",                          :null => false
    t.string   "to",                               :null => false
    t.string   "pay",                              :null => false
    t.string   "qualification",                    :null => false
    t.string   "experience",                       :null => false
    t.string   "favorite",                         :null => false
    t.string   "tel",                              :null => false
    t.string   "hp",                               :null => false
    t.string   "method",                           :null => false
    t.string   "dead_line",                        :null => false
    t.string   "detail",                           :null => false
    t.string   "title",                            :null => false
    t.integer  "counter",       :default => 0
    t.boolean  "notice_flag",   :default => false
    t.boolean  "delete_flag",   :default => false
    t.string   "category",                         :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.string   "title",                             :null => false
    t.boolean  "anomynous_flag", :default => false
    t.boolean  "notice_flag",    :default => false
    t.boolean  "delete_flag",    :default => false
    t.string   "content",                           :null => false
    t.integer  "category",                          :null => false
    t.integer  "job_area"
    t.integer  "vote_up",        :default => 0
    t.integer  "vote_down",      :default => 0
    t.integer  "counter",        :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "nickname",                          :null => false
    t.string   "user_id",                           :null => false
    t.string   "password",                          :null => false
    t.string   "email",                             :null => false
    t.string   "phone_number",                      :null => false
    t.string   "address",                           :null => false
    t.integer  "field",                             :null => false
    t.string   "vet_number",                        :null => false
    t.string   "student_number",                    :null => false
    t.string   "work_name",                         :null => false
    t.string   "work_number",                       :null => false
    t.string   "university",                        :null => false
    t.boolean  "mail_receive",   :default => false
    t.boolean  "sms_receive",    :default => false
    t.boolean  "exit_flag",      :default => false
    t.integer  "level",          :default => 1
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "voted_comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "which",      :null => false
    t.integer  "comment_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "voted_posts", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "which",      :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
