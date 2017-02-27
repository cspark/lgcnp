class GenerateTestModel < ApplicationRecord

  def self.generate_test_custinfo
    c = Custinfo.new
    c.custserial = "10"
    c.n_cust_id = "10"
    c.custname = "red"
    c.sex = "M"
    c.birthyy = "1986"
    c.birthmm = "11"
    c.birthdd = "01"
    c.age = "32"
    c.phone = "0123456789"
    c.lastanaldate = "2017-02-24-18-00"
    c.measureno = "1"
    c.uptdate = "2017/02/24"
    c.is_agree_privacy = "T"
    c.is_agree_after = "T"
    c.is_agree_marketing = "T"
    c.is_agree_thirdparty_info = "T"
    c.ch_cd = "CNP"
    c.save
  end

  def self.generate_test_fctabletinterview
    num = 10
    (7..num).each do |i|
      f = Fctabletinterview.new
      f.custserial = i.to_s
      f.a_1 = i
      f.a_2 = i
      f.a_3 = i
      f.b_1 = i
      f.b_2 = i
      f.b_3 = i
      f.b_4 = i
      f.c_1 = i
      f.d_1 = i
      f.d_2 = i
      f.d_3 = i
      f.d_4 = i
      f.d_5 = i
      f.d_6 = i
      f.d_7 = i
      f.d_8 = i
      f.d_9 = i
      f.d_10 = i
      f.skin_type = "skin_type_gunsung"
      f.before_solution_1 = "elasticity solution"
      f.after_solution_1 = "elasticity solution"
      f.before_solution_2 = "wrinkle solution"
      f.after_solution_2 = "wrinkle solution"
      f.before_serum = "rebalencing"
      f.after_serum = "rebalencing"
      f.before_ample_1 = "regenerating ampoule"
      f.after_ample_1 = "regenerating ampoule"
      f.before_ample_2 = "regenerating ampoule"
      f.after_ample_2 = "regenerating ampoule"
      f.before_made_cosmetic = "skin control EX"
      f.after_made_cosmetic = "skin control EX"
      f.uptdate = "2017-02-10-15-20"
      f.save
    end
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
       user.custserial = 1.to_s
       user.custname = "김수민"
       user.sex = "M"
       user.birthyy = "1985"
       user.birthmm = "11"
       user.birthdd = "21"
       user.age = "33"
       user.phone = "012-345-6789"
       user.address = "nonhyun"
       user.email = "test@test.com"
       user.lastanaldate = "2017-02-21"
       user.measureno = 0
       user.uptdate = "2017-02-21"
       user.is_agree_privacy = "Y"
       user.is_agree_after = "Y"
       user.is_agree_marketing = "Y"
       user.is_agree_thirdparty_info = "Y"
       user.ch_cd = "CNP"
       user.save
       i +=1;
    end
  end

  def self.generate_test_fcpos
    num = 10
    (1..num).each do |i|
       f = Fcpos.new
       f.custserial = i.to_s
       f.faceno = i.to_s+"이름"
       f.measuredate = "measuredate"
       f.measureno = i
       f.uptdate = "2017-02-01"
       f.fh_x = i
       f.fh_y = i
       f.fh_w = i
       f.fh_h = i
       f.ns_x = i
       f.ns_y = i
       f.ns_w = i
       f.ns_h = i
       f.res_x = i
       f.res_y = i
       f.res_w = i
       f.res_h = i
       f.reu_x = i
       f.reu_y = i
       f.reu_w = i
       f.reu_h = i
       f.les_x = i
       f.les_y = i
       f.les_w = i
       f.les_h = i
       f.leu_x = i
       f.leu_y = i
       f.leu_w = i
       f.leu_h = i
       f.rs_x = i
       f.rs_y = i
       f.rs_w = i
       f.rs_h = i
       f.ls_x = i
       f.ls_y = i
       f.ls_w = i
       f.ls_h = i
       f.rt_re_l = i
       f.rt_re_t = i
       f.rt_re_r = i
       f.rt_re_b = i
       f.rt_le_l = i
       f.rt_le_t = i
       f.rt_le_r = i
       f.rt_le_b = i
       f.rt_lip_l = i
       f.rt_lip_t = i
       f.rtrt_lip_r_re_r = i
       f.rt_lip_b = i
       f.rt_res_x = i
       f.rt_res_y = i
       f.rt_les_x = i
       f.rt_les_y = i
       f.save
       i +=1;
    end
  end

  def self.generate_test_schedule
    num = 2
    (1..num).each do |i|
       f = Fcschedule.new
       f.ch_cd = "CNP"
       f.shop_cd = "59100"
       f.reserve_yyyy = "2017"
       f.reserve_mmdd = "0221"
       f.reserve_hhmm = "1500"
       f.custname = "김수민"
       f.phone = "01086919942"
       f.reserve_yn = "Y"
       f.memo = "민트기술"
       f.uptdate = "2017-02-20"
       f.purchase_yn = "Y"
       f.save
       i +=1;
    end
  end

  def self.generate_test_afterinterview
    num = 2
    (1..num).each do |i|
       f = Fcafterinterview.new
       f.custserial = "1"
       f.tablet_interview_id = 1
       f.after_interview_id = 1
       f.a1 = 1
       f.a2 = 2
       f.a3 = 3
       f.a4 = 4
       f.a5 = 5
       f.save
       i +=1;
    end
  end

  def self.generate_test_interview
    num = 2
    (1..num).each do |i|
       f = Fcinterview.new
       f.custserial = "1"
       f.ch_cd = "CNP"
       f.faceno = "F"
       f.measuredate = "2017-02-16-15-00-00"
       f.measureno = 1
       f.uptdate = "2017-02-16"
       f.interview_1 = "1"
       f.interview_2 = "2"
       f.interview_3 = "1,2"
       f.interview_4 = "4"
       f.interview_5 = "5"
       f.interview_6 = "1"
       f.interview_7 = "2"
       f.interview_8 = "3"
       f.interview_9 = "4"
       f.interview_10 = "5"
       f.shop_cd = "5000"
       f.save
       i +=1;
    end
  end

end
