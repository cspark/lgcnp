class GenerateTestModel < ApplicationRecord
  def self.generate_test_fctabletinterview
    f = Fctabletinterview.new

    c = Custinfo.new
    c.custserial = 1
    c.custname = "JJ"
    c.birthyy = "1988"
    c.birthmm = "05"
    c.ch_cd = "CNP"
    c.save
    f.custserial = Custinfo.first.custserial

    f.tablet_interview_id = Fctabletinterview.all.count
    f.ch_cd = "CNP"
    f.skin_type = "skin_type_jisung_senstive"
    f.before_solution_1 = "pore solution"
    f.after_solution_1 = "pore solution"
    f.before_solution_2 = "pore solution"
    f.after_solution_2 = "pore solution"
    f.before_serum = "skin control"
    f.after_serum = "skin control"
    f.before_ample_1 = "pore clinic ampoule"
    f.after_ample_1 = "pore clinic ampoule"
    f.before_ample_2 = "pore clinic ampoule"
    f.after_ample_2 = "pore clinic ampoule"

    f.before_made_cosmetic = "skin control EX"
    f.after_made_cosmetic = "skin control EX"
    f.fcdata_id = 1
    f.uptdate = "2017-02-19-15-20"
    f.is_quick_mode = "F"
    f.save
  end

  def self.generate_test_fcavgdata
    num = 58
    (1..num).each do |i|
       f = Fcavgdata.new
       f.n_index = i
       f.age = 0
       f.pore = 1.0
       f.wrinkle = 1.0
       f.spot_pl = 1.0
       f.spot_uv = 1.0
       f.elasticity = 1.0
       f.porphyrin_ratio = 1.0
       f.e_sebum_t = 1.0
       f.e_sebum_u = 1.0
       f.moisture = 1.0
       f.e_porphyrin_t = 1.0
       f.e_porphyrin_u = 1.0
       f.save
       i +=1;
    end
  end

  def self.generate_test_data
    num = 10
    (1..num).each do |i|
       f = Fcdata.new
       f.custserial = i.to_s
       f.faceno = i.to_s+"faceno"
       f.measuredate = i.to_s+"measuredate"
       f.measureno = i
       f.uptdate = "2017-02-01"
       f.mo_1 = 1.0
       f.mo_7 = 1.0
       f.mo_8 = 1.0
       f.pr_1 = 1
       f.pr_2 = 1
       f.pr_7 = 1
       f.pr_8 = 1
       f.pr_avr = 1
       f.wr_3 = 1
       f.wr_4 = 1
       f.wr_5 = 1
       f.wr_6 = 1
       f.wr_avr = 1
       f.el_7 = 1
       f.el_8 = 1
       f.el_avr = 1
       f.el_angle_7 = 1.0
       f.el_angle_8 = 1.0
       f.sb_1 = 1
       f.sb_2 = 1
       f.sb_7 = 1
       f.sb_8 = 1
       f.sb_avr = 1
       f.pp_1 = 1
       f.pp_2 = 1
       f.pp_7 = 1
       f.pp_8 = 1
       f.pp_avr = 1
       f.pp_ratio_1 = 1
       f.pp_ratio_2 = 1
       f.pp_ratio_7 = 1
       f.pp_ratio_8 = 1
       f.pp_ratio_avr = 1
       f.sp_pl_1 = 1
       f.sp_pl_2 = 1
       f.sp_pl_3 = 1
       f.sp_pl_4 = 1
       f.sp_pl_5 = 1
       f.sp_pl_6 = 1
       f.sp_pl_7 = 1
       f.sp_pl_8 = 1
       f.sp_pl_avr = 1
       f.sp_uv_1 = 1
       f.sp_uv_2 = 1
       f.sp_uv_3 = 1
       f.sp_uv_4 = 1
       f.sp_uv_5 = 1
       f.sp_uv_6 = 1
       f.sp_uv_7 = 1
       f.sp_uv_8 = 1
       f.sp_uv_avr = 1
       f.sk_c_1 = 1
       f.sk_c_2 = 1
       f.sk_c_4 = 1
       f.sk_c_6 = 1
       f.sk_c_7 = 1
       f.sk_c_8 = 1
       f.sk_c_avr = 1
       f.sk_r_1 = 1
       f.sk_r_2 = 1
       f.sk_r_4 = 1
       f.sk_r_6 = 1
       f.sk_r_7 = 1
       f.sk_r_8 = 1
       f.sk_r_avr = 1
       f.sk_g_1 = 1
       f.sk_g_2 = 1
       f.sk_g_4 = 1
       f.sk_g_6 = 1
       f.sk_g_7 = 1
       f.sk_g_8 = 1
       f.sk_g_avr = 1
       f.sk_b_1 = 1
       f.sk_b_2 = 1
       f.sk_b_4 = 1
       f.sk_b_6 = 1
       f.sk_b_7 = 1
       f.sk_b_8 = 1
       f.sk_b_avr = 1
       f.lab_l = 1.0
       f.lab_a = 1.0
       f.lab_b = 1.0
       f.colortype = 1
       f.suntype = 1
       f.skintype = 1
       f.score_r = 1
       f.score_l = 1
       f.save
       i +=1;
    end
  end

  def self.generate_test_custinfo
    num = 10
    (1..num).each do |i|
       user = Custinfo.new
       user.custserial = i.to_s
       user.custname = i.to_s+"이름"
       user.sex = "M"
       user.birthyy = "1985"
       user.birthmm = "11"
       user.birthdd = "21"
       user.age = "33"
       user.phone = "012-345-6789"
       user.address = "nonhyun"
       user.email = "test@test.com"
       user.lastanaldate = "??"
       user.measureno = i
       user.uptdate = "2017-02-01"
       user.is_agree_privacy = "Y"
       user.is_agree_after = "Y"
       user.is_agree_marketing = "Y"
       user.is_agree_thirdparty_info = "Y"
       user.ch_cd = "CNP"
       user.save
       i +=1;
    end
  end

end
