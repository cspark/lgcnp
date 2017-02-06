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

ActiveRecord::Schema.define(version: 20170206080606) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "custinfos", force: :cascade do |t|
    t.string   "custserial",               null: false
    t.string   "custname"
    t.string   "sex"
    t.string   "birthyy"
    t.string   "birthmm"
    t.string   "birthdd"
    t.string   "age"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.string   "lastanaldate"
    t.string   "measureno"
    t.string   "uptdate"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "is_agree_privacy"
    t.string   "is_agree_after"
    t.string   "is_agree_marketing"
    t.string   "is_agree_thirdparty_info"
    t.string   "ch_cd"
  end

  create_table "fc_after_interview_tables", force: :cascade do |t|
    t.string  "custserial",          null: false
    t.integer "tablet_interview_id"
    t.integer "after_interview_id"
    t.integer "a1"
    t.integer "a2"
    t.integer "a3"
    t.integer "a4"
    t.text    "a5"
  end

  create_table "fcavgdata", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fcdata", force: :cascade do |t|
    t.string   "custserial",               null: false
    t.string   "faceno"
    t.string   "measuredate"
    t.integer  "measureno"
    t.string   "uptdate"
    t.float    "mo_1"
    t.float    "mo_7"
    t.float    "mo_8"
    t.integer  "pr_1"
    t.integer  "pr_2"
    t.integer  "pr_7"
    t.integer  "pr_8"
    t.integer  "pr_avr"
    t.integer  "wr_3"
    t.integer  "wr_4"
    t.integer  "wr_5"
    t.integer  "wr_6"
    t.integer  "wr_avr"
    t.integer  "el_7"
    t.integer  "el_8"
    t.integer  "el_avr"
    t.float    "el_angle_7"
    t.float    "el_angle_8"
    t.integer  "sb_1"
    t.integer  "sb_2"
    t.integer  "sb_7"
    t.integer  "sb_8"
    t.integer  "sb_avr"
    t.integer  "pp_1"
    t.integer  "pp_2"
    t.integer  "pp_7"
    t.integer  "pp_8"
    t.integer  "pp_avr"
    t.integer  "pp_ratio_1"
    t.integer  "pp_ratio_2"
    t.integer  "pp_ratio_7"
    t.integer  "pp_ratio_8"
    t.integer  "pp_ratio_avr"
    t.integer  "sp_pl_1"
    t.integer  "sp_pl_2"
    t.integer  "sp_pl_3"
    t.integer  "sp_pl_4"
    t.integer  "sp_pl_5"
    t.integer  "sp_pl_6"
    t.integer  "sp_pl_7"
    t.integer  "sp_pl_8"
    t.integer  "sp_pl_avr"
    t.integer  "sp_uv_1"
    t.integer  "sp_uv_2"
    t.integer  "sp_uv_3"
    t.integer  "sp_uv_4"
    t.integer  "sp_uv_5"
    t.integer  "sp_uv_6"
    t.integer  "sp_uv_7"
    t.integer  "sp_uv_8"
    t.integer  "sp_uv_avr"
    t.integer  "sk_c_1"
    t.integer  "sk_c_2"
    t.integer  "sk_c_4"
    t.integer  "sk_c_6"
    t.integer  "sk_c_7"
    t.integer  "sk_c_8"
    t.integer  "sk_c_avr"
    t.integer  "sk_r_1"
    t.integer  "sk_r_2"
    t.integer  "sk_r_4"
    t.integer  "sk_r_6"
    t.integer  "sk_r_7"
    t.integer  "sk_r_8"
    t.integer  "sk_r_avr"
    t.integer  "sk_g_1"
    t.integer  "sk_g_2"
    t.integer  "sk_g_4"
    t.integer  "sk_g_6"
    t.integer  "sk_g_7"
    t.integer  "sk_g_8"
    t.integer  "sk_g_avr"
    t.integer  "sk_b_1"
    t.integer  "sk_b_2"
    t.integer  "sk_b_4"
    t.integer  "sk_b_6"
    t.integer  "sk_b_7"
    t.integer  "sk_b_8"
    t.integer  "sk_b_avr"
    t.float    "lab_l"
    t.float    "lab_a"
    t.float    "lab_b"
    t.integer  "colortype"
    t.integer  "suntype"
    t.integer  "skintype"
    t.integer  "score_r"
    t.integer  "score_l"
    t.integer  "yanus_status", default: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "fcinterviews", force: :cascade do |t|
    t.string   "custserial",  null: false
    t.string   "faceno"
    t.string   "measuredate"
    t.integer  "measureno"
    t.string   "uptdate"
    t.string   "interview_1"
    t.string   "interview_2"
    t.string   "interview_3"
    t.string   "interview_4"
    t.string   "interview_5"
    t.string   "interview_6"
    t.string   "interview_7"
    t.string   "interview_8"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fcpos", force: :cascade do |t|
    t.string   "custserial",  null: false
    t.string   "faceno"
    t.string   "measuredate"
    t.integer  "measureno"
    t.string   "uptdate"
    t.integer  "fh_x"
    t.integer  "fh_y"
    t.integer  "fh_w"
    t.integer  "fh_h"
    t.integer  "ns_x"
    t.integer  "ns_y"
    t.integer  "ns_w"
    t.integer  "ns_h"
    t.integer  "res_x"
    t.integer  "res_y"
    t.integer  "res_w"
    t.integer  "res_h"
    t.integer  "reu_x"
    t.integer  "reu_y"
    t.integer  "reu_w"
    t.integer  "reu_h"
    t.integer  "les_x"
    t.integer  "les_y"
    t.integer  "les_w"
    t.integer  "les_h"
    t.integer  "leu_x"
    t.integer  "leu_y"
    t.integer  "leu_w"
    t.integer  "leu_h"
    t.integer  "rs_x"
    t.integer  "rs_y"
    t.integer  "rs_w"
    t.integer  "rs_h"
    t.integer  "ls_x"
    t.integer  "ls_y"
    t.integer  "ls_w"
    t.integer  "ls_h"
    t.integer  "rt_re_l"
    t.integer  "rt_re_t"
    t.integer  "rt_re_r"
    t.integer  "rt_re_b"
    t.integer  "rt_le_l"
    t.integer  "rt_le_t"
    t.integer  "rt_le_r"
    t.integer  "rt_le_b"
    t.integer  "rt_lip_l"
    t.integer  "rt_lip_t"
    t.integer  "rt_lip_r"
    t.integer  "rt_lip_b"
    t.integer  "rt_res_x"
    t.integer  "rt_res_y"
    t.integer  "rt_les_x"
    t.integer  "rt_les_y"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fctabletinterviews", force: :cascade do |t|
    t.string   "custserial",                          null: false
    t.integer  "a_1"
    t.integer  "a_2"
    t.integer  "a_3"
    t.integer  "b_1"
    t.integer  "b_2"
    t.integer  "b_3"
    t.integer  "b_4"
    t.integer  "c_1"
    t.integer  "d_1"
    t.integer  "d_2"
    t.integer  "d_3"
    t.integer  "d_4"
    t.integer  "d_5"
    t.integer  "d_6"
    t.integer  "d_7"
    t.integer  "d_8"
    t.integer  "d_9"
    t.integer  "d_10"
    t.string   "skin_type"
    t.string   "solution_before_solution_1"
    t.string   "solution_after_solution_1"
    t.string   "solution_before_solution_2"
    t.string   "solution_after_solution_2"
    t.string   "solution_before_serum"
    t.string   "solution_after_serum"
    t.string   "solution_before_ample_1"
    t.string   "solution_after_ample_1"
    t.string   "solution_before_ample_2"
    t.string   "solution_after_ample_2"
    t.string   "solution_before_ready_made_cosmetic"
    t.string   "solution_after_ready_made_cosmetic"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "table_fc_after_interviews", force: :cascade do |t|
    t.string  "custserial",          null: false
    t.integer "tablet_interview_id"
    t.integer "after_interview_id"
    t.integer "a1"
    t.integer "a2"
    t.integer "a3"
    t.integer "a4"
    t.text    "a5"
  end

end
