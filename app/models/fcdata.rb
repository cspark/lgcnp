class Fcdata < ApplicationRecord
  def to_api_hash
    {
       custserial: self.CUSTSERIAL,
       faceno: self.FACENO,
       measuredate: self.MEASUREDATE,
       measureno: self.MEASURENO,
       uptdate: self.UPTDATE,
       mo_1: self.MO_1,
       mo_7: self.MO_7,
       mo_8: self.MO_8,
       pr_1: self.PR_1,
       pr_2: self.PR_2,
       pr_7: self.PR_7,
       pr_8: self.PR_8,
       pr_avr: self.PR_avr,
       wr_3: self.WR_3,
       wr_4: self.WR_4,
       wr_5: self.WR_5,
       wr_6: self.WR_6,
       wr_avr: self.WR_avr,
       el_7: self.EL_7,
       el_8: self.EL_8,
       el_avr: self.EL_avr,
       el_angle_7: self.EL_angle_7,
       el_angle_8: self.EL_angle_8,
       sb_1: self.SB_1,
       sb_2: self.SB_2,
       sb_7: self.SB_7,
       sb_8: self.SB_8,
       sb_avr: self.SB_avr,
       pp_1: self.PP_1,
       pp_2: self.PP_2,
       pp_7: self.PP_7,
       pp_8: self.PP_8,
       pp_avr: self.PP_avr,
       pp_ratio_1: self.PP_Ratio_1,
       pp_rtio_2: self.PP_Ratio_2,
       pp_ratio_7: self.PP_Ratio_7,
       pp_ratio_8: self.PP_Ratio_8,
       pp_ratio_avr: self.PP_Ratio_avr,
       sp_pl_1: self.SP_PL_1,
       sp_pl_2: self.SP_PL_2,
       sp_pl_3: self.SP_PL_3,
       sp_pl_4: self.SP_PL_4,
       sp_pl_5: self.SP_PL_5,
       sp_pl_6: self.SP_PL_6,
       sp_pl_7: self.SP_PL_7,
       sp_pl_8: self.SP_PL_8,
       sp_pl_avr: self.SP_PL_avr,
       sp_uv_1: self.SP_UV_1,
       sp_uv_2: self.SP_UV_2,
       sp_uv_3: self.SP_UV_3,
       sp_uv_4: self.SP_UV_4,
       sp_uv_5: self.SP_UV_5,
       sp_uv_6: self.SP_UV_6,
       sp_uv_7: self.SP_UV_7,
       sp_uv_8: self.SP_UV_8,
       sp_uv_avr: self.SP_UV_avr,
       sk_c_1: self.SK_C_1,
       sk_c_2: self.SK_C_2,
       sk_c_4: self.SK_C_4,
       sk_c_6: self.SK_C_6,
       sk_c_7: self.SK_C_7,
       sk_c_8: self.SK_C_8,
       sk_c_avr: self.SK_C_avr,
       sk_r_1: self.SK_R_1,
       sk_r_2: self.SK_R_2,
       sk_r_4: self.SK_R_4,
       sk_r_6: self.SK_R_6,
       sk_r_7: self.SK_R_7,
       sk_r_8: self.SK_R_8,
       sk_r_avr: self.SK_R_avr,
       sk_g_1: self.SK_G_1,
       sk_g_2: self.SK_G_2,
       sk_g_4: self.SK_G_4,
       sk_g_6: self.SK_G_6,
       sk_g_7: self.SK_G_7,
       sk_g_8: self.SK_G_8,
       sk_g_avr: self.SK_G_avr,
       sk_b_1: self.SK_B_1,
       sk_b_2: self.SK_B_2,
       sk_b_4: self.SK_B_4,
       sk_b_6: self.SK_B_6,
       sk_b_7: self.SK_B_7,
       sk_b_8: self.SK_B_8,
       sk_b_avr: self.SK_B_avr,
       lab_l: self.Lab_L,
       lab_a: self.Lab_a,
       lab_b: self.Lab_b,
       colortype: self.COLORTYPE,
       suntype: self.SUNTYPE,
       skintype: self.SKINTYPE,
       score_r: self.SCORE_R,
       score_l: self.SCORE_L,
    }
  end

  def input_random_number
    self.MO_1 = SecureRandom.random_number(5)
    self.MO_7 = SecureRandom.random_number(5)
    self.MO_8 = SecureRandom.random_number(5)
    self.PR_1 = SecureRandom.random_number(5)
    self.PR_2 = SecureRandom.random_number(5)
    self.PR_7 = SecureRandom.random_number(5)
    self.PR_8 = SecureRandom.random_number(5)
    self.PR_avr = SecureRandom.random_number(5)
    self.WR_3 = SecureRandom.random_number(5)
    self.WR_4 = SecureRandom.random_number(5)
    self.WR_5 = SecureRandom.random_number(5)
    self.WR_6 = SecureRandom.random_number(5)
    self.WR_avr = SecureRandom.random_number(5)
    self.EL_7 = SecureRandom.random_number(5)
    self.EL_8 = SecureRandom.random_number(5)
    self.EL_avr = SecureRandom.random_number(5)
    self.EL_angle_7 = SecureRandom.random_number(5)
    self.EL_angle_8 = SecureRandom.random_number(5)
    self.SB_1 = SecureRandom.random_number(5)
    self.SB_2 = SecureRandom.random_number(5)
    self.SB_7 = SecureRandom.random_number(5)
    self.SB_8 = SecureRandom.random_number(5)
    self.SB_avr = SecureRandom.random_number(5)
    self.PP_1 = SecureRandom.random_number(5)
    self.PP_2 = SecureRandom.random_number(5)
    self.PP_7 = SecureRandom.random_number(5)
    self.PP_8 = SecureRandom.random_number(5)
    self.PP_avr = SecureRandom.random_number(5)
    self.PP_Ratio_1 = SecureRandom.random_number(5)
    self.PP_Ratio_2 = SecureRandom.random_number(5)
    self.PP_Ratio_7 = SecureRandom.random_number(5)
    self.PP_Ratio_8 = SecureRandom.random_number(5)
    self.PP_Ratio_avr = SecureRandom.random_number(5)
    self.SP_PL_1 = SecureRandom.random_number(5)
    self.SP_PL_2 = SecureRandom.random_number(5)
    self.SP_PL_3 = SecureRandom.random_number(5)
    self.SP_PL_4 = SecureRandom.random_number(5)
    self.SP_PL_5 = SecureRandom.random_number(5)
    self.SP_PL_6 = SecureRandom.random_number(5)
    self.SP_PL_7 = SecureRandom.random_number(5)
    self.SP_PL_8 = SecureRandom.random_number(5)
    self.SP_PL_avr = SecureRandom.random_number(5)
    self.SP_UV_1 = SecureRandom.random_number(5)
    self.SP_UV_2 = SecureRandom.random_number(5)
    self.SP_UV_3 = SecureRandom.random_number(5)
    self.SP_UV_4 = SecureRandom.random_number(5)
    self.SP_UV_5 = SecureRandom.random_number(5)
    self.SP_UV_6 = SecureRandom.random_number(5)
    self.SP_UV_7 = SecureRandom.random_number(5)
    self.SP_UV_8 = SecureRandom.random_number(5)
    self.SP_UV_avr = SecureRandom.random_number(5)
    self.SK_C_1 = SecureRandom.random_number(5)
    self.SK_C_2 = SecureRandom.random_number(5)
    self.SK_C_4 = SecureRandom.random_number(5)
    self.SK_C_6 = SecureRandom.random_number(5)
    self.SK_C_7 = SecureRandom.random_number(5)
    self.SK_C_8 = SecureRandom.random_number(5)
    self.SK_C_avr = SecureRandom.random_number(5)
    self.SK_R_1 = SecureRandom.random_number(5)
    self.SK_R_2 = SecureRandom.random_number(5)
    self.SK_R_4 = SecureRandom.random_number(5)
    self.SK_R_6 = SecureRandom.random_number(5)
    self.SK_R_7 = SecureRandom.random_number(5)
    self.SK_R_8 = SecureRandom.random_number(5)
    self.SK_R_avr = SecureRandom.random_number(5)
    self.SK_G_1 = SecureRandom.random_number(5)
    self.SK_G_2 = SecureRandom.random_number(5)
    self.SK_G_4 = SecureRandom.random_number(5)
    self.SK_G_6 = SecureRandom.random_number(5)
    self.SK_G_7 = SecureRandom.random_number(5)
    self.SK_G_8 = SecureRandom.random_number(5)
    self.SK_G_avr = SecureRandom.random_number(5)
    self.SK_B_1 = SecureRandom.random_number(5)
    self.SK_B_2 = SecureRandom.random_number(5)
    self.SK_B_4 = SecureRandom.random_number(5)
    self.SK_B_6 = SecureRandom.random_number(5)
    self.SK_B_7 = SecureRandom.random_number(5)
    self.SK_B_8 = SecureRandom.random_number(5)
    self.SK_B_avr = SecureRandom.random_number(5)
    self.Lab_L = SecureRandom.random_number(5)
    self.Lab_a = SecureRandom.random_number(5)
    self.Lab_b = SecureRandom.random_number(5)
    self.COLORTYPE = SecureRandom.random_number(5)
    self.SUNTYPE = SecureRandom.random_number(5)
    self.SKINTYPE = SecureRandom.random_number(5)
    self.SCORE_R = SecureRandom.random_number(5)
    self.SCORE_L = SecureRandom.random_number(5)
  end
end
