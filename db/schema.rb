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

ActiveRecord::Schema.define(version: 20170807010756) do

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
    t.string   "ch_cd"
    t.string   "shop_cd"
    t.string   "role"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "allowaccesses", force: :cascade do |t|
    t.string   "low_ip"
    t.string   "high_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custinfos", force: :cascade do |t|
    t.string   "custserial",               null: false
    t.string   "n_cust_id"
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
    t.string   "shop_cd"
    t.string   "gene_barcode"
  end

  create_table "fcafterinterviewrxes", force: :cascade do |t|
    t.string   "custserial",                  null: false
    t.integer  "rx_tablet_interview_id"
    t.integer  "after_interview_id"
    t.integer  "a1"
    t.text     "a1_1"
    t.integer  "a2"
    t.integer  "a3"
    t.integer  "a4"
    t.integer  "a5"
    t.integer  "order"
    t.string   "rx_tablet_interview_uptdate"
    t.string   "uptdate"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "a3_1"
    t.text     "a5_1"
    t.string   "a6"
    t.text     "a7"
    t.text     "a6_1"
  end

  create_table "fcafterinterviews", force: :cascade do |t|
    t.string  "custserial",              null: false
    t.integer "tablet_interview_id"
    t.integer "after_interview_id"
    t.integer "a1"
    t.integer "a2"
    t.integer "a3"
    t.integer "a4"
    t.text    "a5"
    t.integer "order"
    t.text    "a1_1"
    t.string  "tablet_interview_update"
    t.string  "uptdate"
  end

  create_table "fcavgdata", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "n_index"
    t.string   "age"
    t.integer  "pore"
    t.integer  "wrinkle"
    t.integer  "spot_pl"
    t.integer  "spot_uv"
    t.integer  "elasticity"
    t.integer  "porphyrin_ratio"
    t.float    "e_sebum_t"
    t.float    "e_sebum_u"
    t.integer  "moisture"
    t.float    "e_porphyrin_t"
    t.float    "e_porphyrin_u"
  end

  create_table "fcdata", force: :cascade do |t|
    t.string   "custserial",                null: false
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
    t.integer  "yanus_status",  default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "ch_cd"
    t.float    "e_sebum_t"
    t.float    "e_sebum_u"
    t.float    "e_porphyrin_t"
    t.float    "e_porphyrin_u"
    t.integer  "janus_status"
    t.string   "shop_cd"
    t.string   "worry_skin_1"
    t.string   "worry_skin_2"
    t.integer  "m_skintype"
    t.integer  "uf_1"
    t.integer  "uf_2"
    t.integer  "uf_3"
    t.integer  "uf_4"
    t.integer  "uf_5"
    t.integer  "uf_6"
    t.integer  "uf_7"
    t.integer  "uf_8"
    t.integer  "uf_avr"
    t.string   "age"
  end

  create_table "fcgene_interviews", force: :cascade do |t|
    t.string   "custserial"
    t.string   "gene_barcode"
    t.string   "ch_cd"
    t.integer  "measureno"
    t.string   "shop_cd"
    t.string   "q1_height"
    t.string   "q1_weight"
    t.string   "q2"
    t.string   "q3"
    t.string   "q4"
    t.string   "q5"
    t.string   "q7"
    t.string   "q8"
    t.string   "q9"
    t.string   "q10"
    t.string   "q11"
    t.string   "q12"
    t.string   "q13"
    t.string   "q14"
    t.string   "uptdate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "fcinterviews", force: :cascade do |t|
    t.string   "custserial",   null: false
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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "ch_cd"
    t.string   "interview_9"
    t.string   "interview_10"
    t.string   "shop_cd"
  end

  create_table "fcmodecnts", force: :cascade do |t|
    t.string   "modecnt_serial"
    t.string   "shop_cd"
    t.string   "ch_cd"
    t.string   "analdate"
    t.string   "mode_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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
    t.string   "ch_cd"
    t.string   "shop_cd"
  end

  create_table "fcschedules", force: :cascade do |t|
    t.string   "ch_cd",        null: false
    t.string   "shop_cd",      null: false
    t.string   "reserve_yyyy", null: false
    t.string   "reserve_mmdd", null: false
    t.string   "reserve_hhmm", null: false
    t.string   "custname"
    t.string   "phone"
    t.string   "reserve_yn"
    t.string   "memo"
    t.string   "uptdate"
    t.string   "purchase_yn"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "fcshops", force: :cascade do |t|
    t.string   "shop_cd",    null: false
    t.string   "shop_name",  null: false
    t.string   "ch_cd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tel_no"
    t.string   "address"
  end

  create_table "fctabletinterviewrx_summaries", force: :cascade do |t|
    t.integer  "interview_mode_count"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "cnp_tablet_count"
    t.integer  "cnpr_tablet_count"
  end

  create_table "fctabletinterviewrxes", force: :cascade do |t|
    t.string   "custserial",               null: false
    t.string   "ch_cd",                    null: false
    t.integer  "tablet_interview_id",      null: false
    t.integer  "a_1"
    t.integer  "a_2"
    t.integer  "a_3"
    t.integer  "b_1"
    t.integer  "b_2"
    t.integer  "b_3"
    t.integer  "b_4"
    t.integer  "b_5"
    t.integer  "b_6"
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
    t.integer  "d_11"
    t.string   "skin_type"
    t.string   "before_solution_1"
    t.string   "after_solution_1"
    t.string   "before_solution_2"
    t.string   "after_solution_2"
    t.string   "before_ample_1"
    t.string   "after_ample_1"
    t.string   "before_ample_2"
    t.string   "after_ample_2"
    t.string   "uptdate"
    t.string   "is_agree_cant_refund"
    t.string   "is_agree_after"
    t.string   "mmode"
    t.string   "before_production"
    t.string   "after_production"
    t.string   "bb_base"
    t.string   "before_cushion_1"
    t.string   "after_cushion_1"
    t.string   "before_cushion_2"
    t.string   "after_cushion_2"
    t.integer  "fcdata_id"
    t.integer  "turnover_value"
    t.integer  "corneous_value"
    t.float    "stress_value"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "bb_base_before"
    t.string   "bb_base_after"
    t.text     "recommand_program_step_1"
    t.text     "recommand_program_step_2"
    t.text     "recommand_program_step_3"
    t.text     "purchase1"
    t.text     "purchase2"
    t.text     "purchase3"
    t.string   "base_lot"
    t.string   "ampoule_1_lot"
    t.string   "ampoule_2_lot"
    t.string   "mixer_name"
    t.text     "memo"
    t.string   "before_overlap"
    t.string   "after_overlap"
    t.string   "recommand_program1"
    t.string   "recommand_program2"
  end

  create_table "fctabletinterviews", force: :cascade do |t|
    t.string   "custserial",           null: false
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
    t.string   "before_solution_1"
    t.string   "after_solution_1"
    t.string   "before_solution_2"
    t.string   "after_solution_2"
    t.string   "before_serum"
    t.string   "after_serum"
    t.string   "before_ample_1"
    t.string   "after_ample_1"
    t.string   "before_ample_2"
    t.string   "after_ample_2"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "uptdate"
    t.string   "before_made_cosmetic"
    t.string   "after_made_cosmetic"
    t.string   "ch_cd"
    t.integer  "fcdata_id"
    t.integer  "tablet_interview_id"
    t.string   "is_quick_mode"
    t.string   "base_lot"
    t.string   "ampoule_1_lot"
    t.string   "ampoule_2_lot"
    t.string   "mixer_name"
    t.string   "memo"
    t.string   "is_agree_cant_refund"
    t.string   "is_agree_after"
    t.string   "shop_cd"
  end

  create_table "lcare_users", force: :cascade do |t|
    t.string   "n_cust_id",  null: false
    t.string   "cust_hnm"
    t.string   "sex_cd"
    t.integer  "birth_year"
    t.string   "birth_mmdd"
    t.string   "cell_phnno"
    t.string   "u_cust_yn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "login_histories", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privacyaccesshistories", force: :cascade do |t|
    t.string   "adminuser_id"
    t.string   "email"
    t.string   "ip"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "category"
  end

end
