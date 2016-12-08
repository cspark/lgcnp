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

ActiveRecord::Schema.define(version: 20161208023710) do

  create_table "custinfos", force: :cascade do |t|
    t.integer  "SERIAL",       null: false
    t.string   "CUSTNAME"
    t.string   "SEX"
    t.string   "BIRTHYY"
    t.string   "BIRTHMM"
    t.string   "BIRTHDD"
    t.string   "AGE"
    t.string   "PHONE"
    t.string   "ADDRESS"
    t.string   "EAMIL"
    t.string   "LASTANALDATE"
    t.string   "MEASURENO"
    t.string   "UPDATE"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "fcavgdata", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fcdata", force: :cascade do |t|
    t.integer  "CUSTSERIAL",   null: false
    t.string   "FACENO"
    t.string   "MEASUREDATE"
    t.integer  "MEASURENO"
    t.string   "UPTDATE"
    t.float    "MO_1"
    t.float    "MO_7"
    t.float    "MO_8"
    t.integer  "PR_1"
    t.integer  "PR_2"
    t.integer  "PR_7"
    t.integer  "PR_8"
    t.integer  "PR_avr"
    t.integer  "WR_3"
    t.integer  "WR_4"
    t.integer  "WR_5"
    t.integer  "WR_6"
    t.integer  "WR_avr"
    t.integer  "EL_7"
    t.integer  "EL_8"
    t.integer  "EL_avr"
    t.float    "EL_angle_7"
    t.float    "EL_angle_8"
    t.integer  "SB_1"
    t.integer  "SB_2"
    t.integer  "SB_7"
    t.integer  "SB_8"
    t.integer  "SB_avr"
    t.integer  "PP_1"
    t.integer  "PP_2"
    t.integer  "PP_7"
    t.integer  "PP_8"
    t.integer  "PP_avr"
    t.integer  "PP_Ratio_1"
    t.integer  "PP_Ratio_2"
    t.integer  "PP_Ratio_7"
    t.integer  "PP_Ratio_8"
    t.integer  "PP_Ratio_avr"
    t.integer  "SP_PL_1"
    t.integer  "SP_PL_2"
    t.integer  "SP_PL_3"
    t.integer  "SP_PL_4"
    t.integer  "SP_PL_5"
    t.integer  "SP_PL_6"
    t.integer  "SP_PL_7"
    t.integer  "SP_PL_8"
    t.integer  "SP_PL_avr"
    t.integer  "SP_UV_1"
    t.integer  "SP_UV_2"
    t.integer  "SP_UV_3"
    t.integer  "SP_UV_4"
    t.integer  "SP_UV_5"
    t.integer  "SP_UV_6"
    t.integer  "SP_UV_7"
    t.integer  "SP_UV_8"
    t.integer  "SP_UV_avr"
    t.integer  "SK_C_1"
    t.integer  "SK_C_2"
    t.integer  "SK_C_4"
    t.integer  "SK_C_6"
    t.integer  "SK_C_7"
    t.integer  "SK_C_8"
    t.integer  "SK_C_avr"
    t.integer  "SK_R_1"
    t.integer  "SK_R_2"
    t.integer  "SK_R_4"
    t.integer  "SK_R_6"
    t.integer  "SK_R_7"
    t.integer  "SK_R_8"
    t.integer  "SK_R_avr"
    t.integer  "SK_G_1"
    t.integer  "SK_G_2"
    t.integer  "SK_G_4"
    t.integer  "SK_G_6"
    t.integer  "SK_G_7"
    t.integer  "SK_G_8"
    t.integer  "SK_G_avr"
    t.integer  "SK_B_1"
    t.integer  "SK_B_2"
    t.integer  "SK_B_4"
    t.integer  "SK_B_6"
    t.integer  "SK_B_7"
    t.integer  "SK_B_8"
    t.integer  "SK_B_avr"
    t.float    "Lab_L"
    t.float    "Lab_a"
    t.float    "Lab_b"
    t.integer  "COLORTYPE"
    t.integer  "SUNTYPE"
    t.integer  "SKINTYPE"
    t.integer  "SCORE_R"
    t.integer  "SCORE_L"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "fcinterviews", force: :cascade do |t|
    t.integer  "CUSTSERIAL",  null: false
    t.string   "FACENO"
    t.string   "MEASUREDATE"
    t.integer  "MEASURENO"
    t.string   "UPTDATE"
    t.string   "INTERVIEW_1"
    t.string   "INTERVIEW_2"
    t.string   "INTERVIEW_3"
    t.string   "INTERVIEW_4"
    t.string   "INTERVIEW_5"
    t.string   "INTERVIEW_6"
    t.string   "INTERVIEW_7"
    t.string   "INTERVIEW_8"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fcpos", force: :cascade do |t|
    t.integer  "CUSTSERIAL",  null: false
    t.string   "FACENO"
    t.string   "MEASUREDATE"
    t.integer  "MEASURENO"
    t.string   "UPTDATE"
    t.integer  "FH_X"
    t.integer  "FH_Y"
    t.integer  "FH_W"
    t.integer  "FH_H"
    t.integer  "NS_X"
    t.integer  "NS_Y"
    t.integer  "NS_W"
    t.integer  "NS_H"
    t.integer  "RES_X"
    t.integer  "RES_Y"
    t.integer  "RES_W"
    t.integer  "RES_H"
    t.integer  "REU_X"
    t.integer  "REU_Y"
    t.integer  "REU_W"
    t.integer  "REU_H"
    t.integer  "LES_X"
    t.integer  "LES_Y"
    t.integer  "LES_W"
    t.integer  "LES_H"
    t.integer  "LEU_X"
    t.integer  "LEU_Y"
    t.integer  "LEU_W"
    t.integer  "LEU_H"
    t.integer  "RS_X"
    t.integer  "RS_Y"
    t.integer  "RS_W"
    t.integer  "RS_H"
    t.integer  "LS_X"
    t.integer  "LS_Y"
    t.integer  "LS_W"
    t.integer  "LS_H"
    t.integer  "RT_RE_L"
    t.integer  "RT_RE_T"
    t.integer  "RT_RE_R"
    t.integer  "RT_RE_B"
    t.integer  "RT_LE_L"
    t.integer  "RT_LE_T"
    t.integer  "RT_LE_R"
    t.integer  "RT_LE_B"
    t.integer  "RT_LIP_L"
    t.integer  "RT_LIP_T"
    t.integer  "RT_LIP_R"
    t.integer  "RT_LIP_B"
    t.integer  "RT_RES_X"
    t.integer  "RT_RES_Y"
    t.integer  "RT_LES_X"
    t.integer  "RT_LES_Y"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fctabletinterviews", force: :cascade do |t|
    t.string   "CUSTSERIAL",                          null: false
    t.integer  "A_1"
    t.integer  "A_2"
    t.integer  "A_3"
    t.integer  "B_1"
    t.integer  "B_2"
    t.integer  "B_3"
    t.integer  "B_4"
    t.integer  "C_1"
    t.integer  "D_1"
    t.integer  "D_2"
    t.integer  "D_3"
    t.integer  "D_4"
    t.integer  "D_5"
    t.integer  "D_6"
    t.integer  "D_7"
    t.integer  "D_8"
    t.integer  "D_9"
    t.integer  "D_10"
    t.string   "SKIN_TYPE"
    t.string   "SOLUTION_BEFORE_SOLUTION_1"
    t.string   "SOLUTION_AFTER_SOLUTION_1"
    t.string   "SOLUTION_BEFORE_SOLUTION_2"
    t.string   "SOLUTION_AFTER_SOLUTION_2"
    t.string   "SOLUTION_BEFORE_SERUM"
    t.string   "SOLUTION_AFTER_SERUM"
    t.string   "SOLUTION_BEFORE_AMPLE_1"
    t.string   "SOLUTION_AFTER_AMPLE_1"
    t.string   "SOLUTION_BEFORE_AMPLE_2"
    t.string   "SOLUTION_AFTER_AMPLE_2"
    t.string   "SOLUTION_BEFORE_READY_MADE_COSMETIC"
    t.string   "SOLUTION_AFTER_READY_MADE_COSMETIC"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
