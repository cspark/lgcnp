require 'sys/filesystem'

class GenerateTestModel < ApplicationRecord

  def self.generate_test_custinfo
    c = Custinfo.new
    c.custserial = "11"
    c.n_cust_id = "11"
    c.custname = "망고"
    c.sex = "M"
    c.birthyy = "2000"
    c.birthmm = "07"
    c.birthdd = "03"
    c.age = "18"
    c.phone = "0123456789"
    c.lastanaldate = "2017-01-15-18-00"
    c.measureno = "1"
    c.uptdate = "2017/01/15"
    c.is_agree_privacy = "T"
    c.is_agree_after = "T"
    c.is_agree_marketing = "T"
    c.is_agree_thirdparty_info = "T"
    c.ch_cd = "CNP"
    c.save
  end

  def self.generate_test_fctabletinterview
    i = 1
    Fctabletinterview.all.each do |f|
      i = 1
      f = Fctabletinterview.new
      f.custserial = 3.to_s
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
      f.before_solution_2 = "elasticity solution"
      f.after_solution_2 = "elasticity solution"
      f.before_serum = "deep humect"
      f.after_serum = "deep humect"
      f.before_ample_1 = "perming ampoule"
      f.after_ample_1 = "perming ampoule"
      f.before_ample_2 = "perming ampoule"
      f.after_ample_2 = "perming ampoule"
      f.before_made_cosmetic = "skin control EX"
      f.after_made_cosmetic = "skin control EX"
      f.uptdate = "2017-04-05-12-00"
      f.ch_cd = "CNP"
      f.fcdata_id = 1.to_s
      f.tablet_interview_id = 2
      f.is_quick_mode = "T"
      f.is_agree_cant_refund = "T"
      f.is_agree_after = "T"
      f.base_lot = "1"
      f.save
      i += 1
    end
  end

  def self.generate_test_fctabletinterviewrx
    i = 1
    Fctabletinterview.all.each do |f|
      i = 1
      f = Fctabletinterviewrx.new
      f.custserial = 4.to_s
      f.a_1 = i
      f.a_2 = i
      f.a_3 = i
      f.b_1 = i
      f.b_2 = i
      f.b_3 = i
      f.b_4 = i
      f.b_5 = i
      f.b_6 = i
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
      f.d_11 = i
      f.skin_type = "skin_type_gunsung"
      f.before_solution_1 = "elasticity solution"
      f.after_solution_1 = "elasticity solution"
      f.before_solution_2 = "elasticity solution"
      f.after_solution_2 = "elasticity solution"
      f.before_ample_1 = "perming ampoule"
      f.after_ample_1 = "perming ampoule"
      f.before_ample_2 = "perming ampoule"
      f.after_ample_2 = "perming ampoule"
      f.uptdate = "2017-04-05-12-00"
      f.ch_cd = "CNP"
      f.fcdata_id = 1.to_s
      f.tablet_interview_id = 2
      f.is_agree_cant_refund = "T"
      f.is_agree_after = "T"
      f.turnover_value =  2
      f.corneous_value = 10
      f.stress_value = 3
      f.recommand_program_step_1 = "%EB%B0%B8%EB%9F%B0%EC%8A%A4+%ED%86%A0%EB%84%88"
      f.recommand_program_step_2 = "%EB%A6%AC%EB%89%B4+%ED%81%AC%EB%A6%BC%2C+%EC%97%90%EB%84%88%EC%A7%80+%EC%95%B0%ED%94%8C"
      f.recommand_program_step_3 = "%EC%9B%8C%ED%84%B0+%EC%A0%A4+%ED%81%AC%EB%A6%BC%2C+%EB%94%A5+%ED%81%AC%EB%A6%BC"
      f.purchase1 = "%EB%B0%B8%EB%9F%B0%EC%8A%A4+%ED%86%A0%EB%84%88"
      f.purchase2 = "%EB%A6%AC%EB%89%B4+%ED%81%AC%EB%A6%BC"
      f.purchase3 = "%EC%9B%8C%ED%84%B0+%EC%A0%A4+%ED%81%AC%EB%A6%BC"
      f.save
      i += 1
    end
  end

  def self.generate_test_fcavgdata
     i = 79

     f = Fcavgdata.new
     f.n_index = i
     f.age = "Male_Age36-40_Grade1"
     f.pore = i-60
     f.wrinkle = i-60
     f.moisture = i-60
     f.spot_pl = i-60
     f.spot_uv = i-60
     f.elasticity = i-60
     f.porphyrin_ratio = i-60
     f.e_sebum_t = i-60
     f.e_sebum_u = i-60
     f.e_porphyrin_t = i-60
     f.e_porphyrin_u = i-60
     f.save
     i +=1;
  end

  def self.generate_test_data
    num = 10
    (1..num).each do |i|
       f = Fcdata.new
       f.custserial = 4.to_s
       f.ch_cd = "RLAB"
       f.faceno = "F"
       f.measuredate = "2017-04-21-13-00-00"
       f.measureno = 1
       f.uptdate = "2017-04-21"
       f.mo_1 = 1.0
       f.mo_7 = 1.0
       f.mo_8 = 1.0
       f.pr_1 = 1
       f.pr_2 = 2
       f.pr_7 = 7
       f.pr_8 = 8
       f.pr_avr = 1
       f.wr_3 = 3
       f.wr_4 = 4
       f.wr_5 = 5
       f.wr_6 = 6
       f.wr_avr = 1
       f.el_7 = 7
       f.el_8 = 8
       f.el_avr = 1
       f.el_angle_7 = 1.0
       f.el_angle_8 = 1.0
       f.sb_1 = 1
       f.sb_2 = 2
       f.sb_7 = 7
       f.sb_8 = 8
       f.sb_avr = 1
       f.pp_1 = 1
       f.pp_2 = 2
       f.pp_7 = 7
       f.pp_8 = 8
       f.pp_avr = 1
       f.pp_ratio_1 = 1
       f.pp_ratio_2 = 2
       f.pp_ratio_7 = 7
       f.pp_ratio_8 = 8
       f.pp_ratio_avr = 1
       f.sp_pl_1 = 1
       f.sp_pl_2 = 2
       f.sp_pl_3 = 3
       f.sp_pl_4 = 4
       f.sp_pl_5 = 5
       f.sp_pl_6 = 6
       f.sp_pl_7 = 7
       f.sp_pl_8 = 8
       f.sp_pl_avr = 1
       f.sp_uv_1 = 1
       f.sp_uv_2 = 2
       f.sp_uv_3 = 3
       f.sp_uv_4 = 4
       f.sp_uv_5 = 5
       f.sp_uv_6 = 6
       f.sp_uv_7 = 7
       f.sp_uv_8 = 8
       f.sp_uv_avr = 1
       f.sk_c_1 = 1
       f.sk_c_2 = 2
       f.sk_c_4 = 4
       f.sk_c_6 = 6
       f.sk_c_7 = 7
       f.sk_c_8 = 8
       f.sk_c_avr = 1
       f.sk_r_1 = 1
       f.sk_r_2 = 2
       f.sk_r_4 = 4
       f.sk_r_6 = 6
       f.sk_r_7 = 7
       f.sk_r_8 = 8
       f.sk_r_avr = 1
       f.sk_g_1 = 1
       f.sk_g_2 = 2
       f.sk_g_4 = 4
       f.sk_g_6 = 6
       f.sk_g_7 = 7
       f.sk_g_8 = 8
       f.sk_g_avr = 1
       f.sk_b_1 = 1
       f.sk_b_2 = 2
       f.sk_b_4 = 4
       f.sk_b_6 = 6
       f.sk_b_7 = 7
       f.sk_b_8 = 8
       f.sk_b_avr = 1
       f.lab_l = 1.0
       f.lab_a = 1.0
       f.lab_b = 1.0
       f.colortype = 1
       f.suntype = 1
       f.skintype = 1
       f.score_r = 1
       f.score_l = 1
       f.m_skintype = 1
       f.shop_cd = "1005"
       worry_skin_1 = 1
       worry_skin_2 = 1
       f.save
       i +=1;
    end
  end

  def self.generate_test_custinfo
    num = 10
    (1..num).each do |i|
       user = Custinfo.new
       user.custserial = 4.to_s
       user.custname = "kimsoomin"
       user.sex = "F"
       user.birthyy = "1985"
       user.birthmm = "11"
       user.birthdd = "21"
       user.age = "31"
       user.phone = "0123456789"
       user.address = "nonhyun"
       user.email = "test@test.com"
       user.lastanaldate = "2017-04-07"
       user.measureno = 1
       user.uptdate = "2017-04-07"
       user.is_agree_privacy = "T"
       user.is_agree_after = "T"
       user.is_agree_marketing = "T"
       user.is_agree_thirdparty_info = "T"
       user.ch_cd = "RLAB"
       user.shop_cd = "1005"
       user.save
       i +=1;
    end
  end

  def self.generate_test_fcpos
    num = 10
    (1..num).each do |i|
       i = 1
       f = Fcpos.new
       f.ch_cd = "CNP"
       f.custserial = 7.to_s
       f.faceno = "F"
       f.measuredate = "2017-02-02-13-00-00"
       f.measureno = 1
       f.uptdate = "2017-02-02"
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
       f.rt_lip_r = i
       f.rt_lip_b = i
       f.rt_res_x = i
       f.rt_res_y = i
       f.rt_les_x = i
       f.rt_les_y = i
       f.shop_cd = "1004"
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
       f.reserve_mmdd = "0315"
       f.reserve_hhmm = "1500"
       f.custname = "kimsoomin"
       f.phone = "0123456789"
       f.reserve_yn = "T"
       f.memo = "CNP"
       f.uptdate = "2017-03-14"
       f.purchase_yn = "T"
       f.save
       i +=1;
    end
  end

  def self.generate_test_afterinterview
    i = 6
    f = Fcafterinterview.new
    f.custserial = i.to_s
    f.tablet_interview_id = i
    f.after_interview_id = i
    f.a1 = 1
    f.a2 = 2
    f.a3 = 3
    f.a4 = 4
    f.a5 = 5
    f.order = 0
    f.a1_1 = "파워 블로거"
    f.tablet_interview_update = "2017-03-15-13-00"
    f.uptdate = "2017-03-15-13-00"
    f.save
    i +=1;
  end

  def self.generate_test_interview
    num = 2
    (1..num).each do |i|
       f = Fcinterview.new
       f.custserial = "2"
       f.ch_cd = "BEAU"
       f.faceno = "F"
       f.measuredate = "2017-02-01-15-00-00"
       f.measureno = 1
       f.uptdate = "2017-02-01"
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
       f.shop_cd = "505415"
       f.save
       i +=1;
    end
  end

  def self.generate_test_adminuser
     f = AdminUser.new
     f.email = "505415"
     f.ch_cd = "BEAU"
     f.shop_cd = "505415"
     f.save
  end

  def skin_type_error
    array = Fcdata.where(skintype: 9).pluck(:custserial).uniq
    rx = Fctabletinterviewrx.where(mmode: "Total").where(custserial: array)
    temp = []
    rx.each do |interview|
      if !interview.skin_type.include?("u_zone_boghab")
        temp << interview.custserial.to_i
        temp = temp.uniq
      end
    end
  end

  def skin_type_error
    ft = Fctabletinterviewrx.where(before_solution_1: "SKIN_WRINKLE")
    array = []
    ft.each do |interview|
      if interview.before_solution_2 == "SKIN_WRINKLE"
        array << interview.custserial.to_i
      end
    end
    array = array.uniq
  end

  def change_before_overlap
    fts = Fctabletinterviewrx.all
    fts.each do |interview|
      serial = interview.custserial.to_i.to_s
      measureno = interview.fcdata_id.to_i.to_s
      # serial = 1239
      # measureno = 6
      face_data = Fcdata.where(custserial: serial).where(measureno: measureno).last
      data = face_data.to_api_hash_for_admin
      Rails.logger.info data
      sb = data[:sb_graph]
      pp = data[:pp_graph]
      el = data[:el_graph]
      wr = data[:wr_graph]
      mo = data[:mo_graph]

      array = []
      array << [sb, "SCORE_TROUBLE"]
      array << [pp, "SCORE_PIGMENT"]
      array << [el, "SCORE_ELASTICITY"]
      array << [wr, "SKIN_WRINKLE"]
      array << [mo, "SCORE_WATER"]
      array = array.sort

      if array[0][0] - array[1][0] <= -2
        interview.before_overlap = array[0][1]
      end
      if interview.after_solution_1 == interview.after_solution_2
        interview.after_overlap = interview.after_solution_2
      end
      interview.save
    end
  end

  def debug_after_overlap
    temp_array = []
    fts = Fctabletinterviewrx.all
    fts.each do |interview|
      if interview.after_solution_1 == interview.after_solution_2
        temp_array << interview.custserial.to_i
      end
    end
  end

  def change_before_solution
    change_before_solution_1_array = []
    change_before_solution_2_array = []
    interview = Fctabletinterview.where(custserial: 1258).first
    fts = Fctabletinterview.all
    fts.each do |interview|
      serial = interview.custserial.to_i
      measureno = interview.fcdata_id.to_i

      if measureno != 0
        face_data = Fcdata.where(custserial: serial).where(measureno: measureno).last
        data = face_data.to_api_hash_for_debug
        sb = data[:sb_graph]
        pp = data[:pp_graph]
        el = data[:el_graph]
        wr = data[:wr_graph]
        pr = data[:pr_graph]

        pr_graph_me = 99.9 - data[:pr_graph_me]
        wr_graph_me = data[:wr_graph_me]
        el_graph_me = data[:el_graph_me]
        sb_graph_me = 99.9 - data[:sb_graph_me]
        pp_graph_me = 99.9 - data[:pp_graph_me]

        array = []
        array << [pr, pr_graph_me, 1, "pore solution"]
        array << [sb, sb_graph_me, 2, "trouble solution"]
        array << [pp, pp_graph_me, 3, "pigment solution"]
        array << [wr, wr_graph_me, 4, "wrinkle solution"]
        array << [el, el_graph_me, 5, "elasticity solution"]

        array = array.sort

        interview.before_solution_1_new = array.first[3]
        interview.before_solution_2_new = array.second[3]
        interview.save
      end
    end
  end

  def self.disk_size_vda1
    stat = Sys::Filesystem.stat("/")
    mb_available = stat.block_size * stat.blocks_available / 1024 / 1024
    return mb_available
  end

  def self.disk_size_mount_disk
    stat = Sys::Filesystem.stat("/dev/mapper/DATAVG-lv_data")
    Rails.logger.info "mount_disk stat!!!!!"
    Rails.logger.info stat.files_available
    Rails.logger.info stat.path
    Rails.logger.info stat.block_size
    Rails.logger.info stat.blocks_available
    mb_available = stat.block_size * stat.blocks_available / 1024 / 1024
    return mb_available
  end

end
