class Fcdata < ApplicationRecord
  self.table_name = "fcdata"
  # 1 이마 2 코 3 오른쪽 눈옆 4 오른쪽 눈밑 5 왼쪽 눈옆 6 왼쪽 눈밑 7 오른쪽 볼 8 왼쪽 볼

  def to_api_hash
    {
       custserial: custserial,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno,
       uptdate: uptdate,
       mo_1: get_mo_to_five(value: mo_1),
       mo_7: get_mo_to_five(value: mo_7),
       mo_8: get_mo_to_five(value: mo_8),
       pr_1: pr_1,
       pr_2: pr_2,
       pr_7: pr_7,
       pr_8: pr_8,
       pr_avr: pr_avr,
       pr_graph: get_graph_data(type: "pore"),
      #  pr_graph_min: get_vertical_graph_min(type: "pore"),
      #  pr_graph_max: get_vertical_graph_max(type: "pore"),
       pr_graph_min: 0,
       pr_graph_max: 100,
       pr_graph_avr: get_vertical_graph_avr(type: "pore"),
       pr_graph_me: get_vertical_graph_me(type: "pore"),
       wr_3: wr_3,
       wr_4: wr_4,
       wr_5: wr_5,
       wr_6: wr_6,
       wr_avr: wr_avr,
       wr_graph: get_graph_data(type: "wr"),
       wr_graph_min: get_vertical_graph_min(type: "wr"),
       wr_graph_max: get_vertical_graph_max(type: "wr"),
       wr_graph_avr: get_vertical_graph_avr(type: "wr"),
       wr_graph_me: wr_avr,
       el_7: el_7,
       el_8: el_8,
       el_avr: el_avr,
       el_graph: get_graph_data(type: "el"),
       el_graph_min: get_vertical_graph_min(type: "el"),
       el_graph_max: get_vertical_graph_max(type: "el"),
       el_graph_avr: get_vertical_graph_avr(type: "el"),
       el_graph_me: el_avr,
       el_angle_7: el_angle_7,
       el_angle_8: el_angle_8,
       sb_1: sb_1,
       sb_2: sb_2,
       sb_7: sb_7,
       sb_8: sb_8,
       sb_avr: sb_avr,
       sb_graph: get_graph_data(type: "sb"),
       sb_graph_min: get_vertical_graph_min(type: "sb"),
       sb_graph_max: get_vertical_graph_max(type: "sb"),
       sb_graph_avr: get_vertical_graph_avr(type: "sb"),
       sb_graph_me: sb_avr,
       pp_1: pp_1,
       pp_2: pp_2,
       pp_7: pp_7,
       pp_8: pp_8,
       pp_avr: pp_avr,
       pp_ratio_1: pp_ratio_1,
       pp_ratio_2: pp_ratio_2,
       pp_ratio_7: pp_ratio_7,
       pp_ratio_8: pp_ratio_8,
       pp_ratio_avr: pp_ratio_avr,
       pp_graph: get_graph_data(type: "pp"),
       pp_graph_min: get_vertical_graph_min(type: "pp"),
       pp_graph_max: get_vertical_graph_max(type: "pp"),
       pp_graph_avr: get_vertical_graph_avr(type: "pp"),
       pp_graph_me: pp_ratio_avr,
       sp_pl_1: sp_pl_1,
       sp_pl_2: sp_pl_2,
       sp_pl_3: sp_pl_3,
       sp_pl_4: sp_pl_4,
       sp_pl_5: sp_pl_5,
       sp_pl_6: sp_pl_6,
       sp_pl_7: sp_pl_7,
       sp_pl_8: sp_pl_8,
       sp_pl_avr: sp_pl_avr,
       sp_uv_1: sp_uv_1,
       sp_uv_2: sp_uv_2,
       sp_uv_3: sp_uv_3,
       sp_uv_4: sp_uv_4,
       sp_uv_5: sp_uv_5,
       sp_uv_6: sp_uv_6,
       sp_uv_7: sp_uv_7,
       sp_uv_8: sp_uv_8,
       sp_uv_avr: sp_uv_avr,
       sk_c_1: sk_c_1,
       sk_c_2: sk_c_2,
       sk_c_4: sk_c_4,
       sk_c_6: sk_c_6,
       sk_c_7: sk_c_7,
       sk_c_8: sk_c_8,
       sk_c_avr: sk_c_avr,
       sk_r_1: sk_r_1,
       sk_r_2: sk_r_2,
       sk_r_4: sk_r_4,
       sk_r_6: sk_r_6,
       sk_r_7: sk_r_7,
       sk_r_8: sk_r_8,
       sk_r_avr: sk_r_avr,
       sk_g_1: sk_g_1,
       sk_g_2: sk_g_2,
       sk_g_4: sk_g_4,
       sk_g_6: sk_g_6,
       sk_g_7: sk_g_7,
       sk_g_8: sk_g_8,
       sk_g_avr: sk_g_avr,
       sk_b_1: sk_b_1,
       sk_b_2: sk_b_2,
       sk_b_4: sk_b_4,
       sk_b_6: sk_b_6,
       sk_b_7: sk_b_7,
       sk_b_8: sk_b_8,
       sk_b_avr: sk_b_avr,
       lab_l: lab_l,
       lab_a: lab_a,
       lab_b: lab_b,
       colortype: colortype,
       suntype: suntype,
       skintype: skintype,
       score_r: score_l.to_i - 5,
       score_l: score_r.to_i - 5,
       e_sebum_t: e_sebum_t,
       e_sebum_t_graph_min: get_vertical_graph_min(type: "e_sebum_t"),
       e_sebum_t_graph_max: get_vertical_graph_max(type: "e_sebum_t"),
       e_sebum_t_graph_avr: get_vertical_graph_avr(type: "e_sebum_t"),
       e_sebum_u: e_sebum_u,
       e_sebum_u_graph_min: get_vertical_graph_min(type: "e_sebum_u"),
       e_sebum_u_graph_max: get_vertical_graph_max(type: "e_sebum_u"),
       e_sebum_u_graph_avr: get_vertical_graph_avr(type: "e_sebum_u"),
       e_porphyrin_t: e_porphyrin_t,
       e_porphyrin_t_graph_min: get_vertical_graph_min(type: "e_porphyrin_t"),
       e_porphyrin_t_graph_max: get_vertical_graph_max(type: "e_porphyrin_t"),
       e_porphyrin_t_graph_avr: get_vertical_graph_avr(type: "e_porphyrin_t"),
       e_porphyrin_u: e_porphyrin_u,
       e_porphyrin_u_graph_min: get_vertical_graph_min(type: "e_porphyrin_u"),
       e_porphyrin_u_graph_max: get_vertical_graph_max(type: "e_porphyrin_u"),
       e_porphyrin_u_graph_avr: get_vertical_graph_avr(type: "e_porphyrin_u"),
       dry_t: mo_1,
       dry_t_graph_min: get_vertical_graph_min(type: "moisture"),
       dry_t_graph_max: get_vertical_graph_max(type: "moisture"),
       dry_t_graph_avr: get_vertical_graph_avr(type: "moisture"),
       dry_u: (mo_7 + mo_8) / 2,
       dry_u_graph_min: get_vertical_graph_min(type: "moisture"),
       dry_u_graph_max: get_vertical_graph_max(type: "moisture"),
       dry_u_graph_avr: get_vertical_graph_avr(type: "moisture"),
    }
  end

  #TZone 이마 수분 측정 평균값 : Moisture 본인값 : MO_1
  #UZone 양볼 수분 측정 평균값 : Moisture 본인값 : MO_7 / 8 의 평균

  #Vertical / Horizontal Graph
  def get_vertical_graph_min(type: nil)
    if type == "moisture"
      return Fcavgdata.where(age: "AgeALL_Min").first.moisture.to_i
    end

    if type == "e_sebum_t"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_sebum_t.to_i
    end

    if type == "e_sebum_u"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_sebum_u.to_i
    end

    if type == "e_porphyrin_t"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_t.to_i
    end

    if type == "e_porphyrin_u"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_u.to_i
    end

    if type == "pore"
      return Fcavgdata.where(age: "AgeALL_Min").first.pore.to_i
    end

    if type == "sb"
      # 트러블
      return (Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_u.to_i + Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_t.to_i) / 2
    end

    if type == "wr"
      return Fcavgdata.where(age: "AgeALL_Min").first.wrinkle.to_i
    end

    if type == "el"
      return Fcavgdata.where(age: "AgeALL_Min").first.elasticity.to_i
    end

    if type == "pp"
      return Fcavgdata.where(age: "AgeALL_Min").first.spot_pl.to_i
    end
  end

  def get_vertical_graph_max(type: nil)
    if type == "moisture"
      return Fcavgdata.where(age: "AgeALL_Max").first.moisture.to_i
    end

    if type == "e_sebum_t"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_sebum_t.to_i
    end

    if type == "e_sebum_u"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_sebum_u.to_i
    end

    if type == "e_porphyrin_t"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_t.to_i
    end

    if type == "e_porphyrin_u"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_u.to_i
    end

    if type == "pore"
        return Fcavgdata.where(age: "AgeALL_Max").first.pore.to_i
    end

    if type == "sb"
      # 트러블
      return (Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_u.to_i + Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_t.to_i) / 2
    end

    if type == "wr"
      return Fcavgdata.where(age: "AgeALL_Max").first.wrinkle.to_i
    end

    if type == "el"
      return Fcavgdata.where(age: "AgeALL_Max").first.elasticity.to_i
    end

    if type == "pp"
      return Fcavgdata.where(age: "AgeALL_Max").first.spot_pl.to_i
    end
  end

  def get_vertical_graph_me(type: nil)
    if self.custserial.nil?
      return 0
    end

    user = Custinfo.where(custserial: self.custserial).first
    age = user.age
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")

    if type == "moisture"
      return (Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_t.to_i + Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_t.to_i) / 2
    end

    if type == "e_sebum_t"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_t.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_t.to_i) / 2
    end

    if type == "e_sebum_u"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_u.to_i) / 2
    end

    if type == "e_porphyrin_t"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_i) / 2
    end

    if type == "e_porphyrin_u"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_i) / 2
    end

    if type == "pore"
        me = pr_avr
        min_value = get_vertical_graph_min(type: type)
        max_value = get_vertical_graph_max(type: type)
        first_split_point = Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_i
        second_split_point = Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_i

        if me < first_split_point
          me = (me / first_split_point - min_value) * 33.3
        end

        if me >= first_split_point && me < second_split_point
          me = (me / second_split_point - first_split_point) * 33.3
        end

        if me >= second_split_point
          me = (me / max_value - second_split_point) * 33.3
        end
        return me
    end

    if type == "sb"
        return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_i) / 2
    end

    if type == "wr"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.wrinkle.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.wrinkle.to_i) / 2
    end

    if type == "el"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.elasticity.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.elasticity.to_i) / 2
    end

    if type == "pp"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.spot_pl.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.spot_pl.to_i) / 2
    end
  end

  def get_vertical_graph_avr(type: nil)
    if self.custserial.nil?
      return 0
    end

    user = Custinfo.where(custserial: self.custserial).first
    age = user.age
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")

    if type == "moisture"
      return (Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_t.to_i + Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_t.to_i) / 2
    end

    if type == "e_sebum_t"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_t.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_t.to_i) / 2
    end

    if type == "e_sebum_u"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_u.to_i) / 2
    end

    if type == "e_porphyrin_t"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_i) / 2
    end

    if type == "e_porphyrin_u"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_i) / 2
    end

    if type == "pore"
        age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_i) / 2
        min_value = get_vertical_graph_min(type: type)
        max_value = get_vertical_graph_max(type: type)
        first_split_point = Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_i
        second_split_point = Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_i

        if age_avr < first_split_point
          age_avr = (age_avr / first_split_point - min_value) * 33.3
        end

        if age_avr >= first_split_point && age_avr < second_split_point
          age_avr = (age_avr / second_split_point - first_split_point) * 33.3
        end

        if age_avr >= second_split_point
          age_avr = (age_avr / max_value - second_split_point) * 33.3
        end
        return age_avr
    end

    if type == "sb"
        return (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_i) / 2
    end

    if type == "wr"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.wrinkle.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.wrinkle.to_i) / 2
    end

    if type == "el"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.elasticity.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.elasticity.to_i) / 2
    end

    if type == "pp"
      return (Fcavgdata.where(age: avg_grade_2_field_name).first.spot_pl.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.spot_pl.to_i) / 2
    end
  end

  def get_graph_data(type: nil)
    # 수분은 높을 수록 좋은 것
    if self.custserial.nil?
      return 0
    end
    user = Custinfo.where(custserial: self.custserial).first
    age = user.age
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")
    #abcd123456!

    if type == "pore"
      avr = self.pr_avr
      Rails.logger.info avg_grade_1_field_name
      avr1 = Fcavgdata.where(age: avg_grade_1_field_name).first.pore.to_i
      avr2 = Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_i
      avr3 = Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_i
      avr4 = Fcavgdata.where(age: avg_grade_4_field_name).first.pore.to_i

      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end

    if type == "wr"
      avr = self.wr_avr
      avr1 = Fcavgdata.where(age: avg_grade_1_field_name).first.wrinkle.to_i
      avr2 = Fcavgdata.where(age: avg_grade_2_field_name).first.wrinkle.to_i
      avr3 = Fcavgdata.where(age: avg_grade_3_field_name).first.wrinkle.to_i
      avr4 = Fcavgdata.where(age: avg_grade_4_field_name).first.wrinkle.to_i

      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end

    if type == "el"
      avr = self.el_avr
      avr1 = Fcavgdata.where(age: avg_grade_1_field_name).first.elasticity.to_i
      avr2 = Fcavgdata.where(age: avg_grade_2_field_name).first.elasticity.to_i
      avr3 = Fcavgdata.where(age: avg_grade_3_field_name).first.elasticity.to_i
      avr4 = Fcavgdata.where(age: avg_grade_4_field_name).first.elasticity.to_i

      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end

    if type == "sb"
      # 트러블
      # E_PORPHYTRIN_T	E_PORPHYTRIN_U 평균값
      avr = self.sb_avr

      avr1 = (Fcavgdata.where(age: avg_grade_1_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_1_field_name).first.e_porphyrin_t.to_i) / 2
      avr2 = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_i) / 2
      avr3 = (Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_i) / 2
      avr4 = (Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_u.to_i + Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_t.to_i) / 2

      Rails.logger.info "sb avr4"
      Rails.logger.info Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_u.to_i
      Rails.logger.info Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_t.to_i
      Rails.logger.info avr4
      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end

    if type == "pp"
      # 색소침착 SPOT_PL
      avr = self.sp_pl_avr
      avr1 = Fcavgdata.where(age: avg_grade_1_field_name).first.spot_pl.to_i
      avr2 = Fcavgdata.where(age: avg_grade_2_field_name).first.spot_pl.to_i
      avr3 = Fcavgdata.where(age: avg_grade_3_field_name).first.spot_pl.to_i
      avr4 = Fcavgdata.where(age: avg_grade_4_field_name).first.spot_pl.to_i
      Rails.logger.info "PPPP"
      Rails.logger.info avr2
      Rails.logger.info avr3

      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end
  end

  def convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    if avr <= avr1
      return 4
    end

    if avr > avr1 && avr < avr2
      return 3
    end

    if avr >= avr2 && avr < avr3
      return 2
    end

    if avr >= avr3 && avr < avr4
      return 1
    end

    if avr > avr4
      return 0
    end

    return 0
  end

  def generate_age_data_field(age: age)
    field_name = "Age"
    if age.to_i < 10
      return field_name.concat("1-10_Grade")
    end

    if age.to_i > 10 && age.to_i < 16
      return field_name.concat("11-15_Grade")
    end

    if age.to_i > 15 && age.to_i < 21
      return field_name.concat("16-20_Grade")
    end

    if age.to_i > 20 && age.to_i < 26
      return field_name.concat("21-25_Grade")
    end

    if age.to_i > 25 && age.to_i < 31
      return field_name.concat("26-30_Grade")
    end

    if age.to_i > 30 && age.to_i < 36
      return field_name.concat("31-35_Grade")
    end

    if age.to_i > 35 && age.to_i < 41
      return field_name.concat("36-40_Grade")
    end

    if age.to_i > 40 && age.to_i < 46
      return field_name.concat("41-45_Grade")
    end

    if age.to_i > 45 && age.to_i < 51
      return field_name.concat("46-50_Grade")
    end

    if age.to_i > 50 && age.to_i < 56
      return field_name.concat("51-55_Grade")
    end

    if age.to_i > 55 && age.to_i < 61
      return field_name.concat("56-60_Grade")
    end

    if age.to_i > 60 && age.to_i < 71
      return field_name.concat("61-70_Grade")
    end

    if age.to_i > 70
      return field_name.concat("71_Grade")
    end
  end

  def get_mo_to_five(value: value)
    # AVG Data 의 Moisture Grade 3, 2 번을 참고

    low = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_i
    high = Fcavgdata.where(age: "AgeALL_Grade4").first.moisture.to_i

    if value.to_i < low
      return 0
    end

    if value.to_i > low && value.to_i < high
      return 2
    end

    if value.to_i > high
      return 5
    end

  end

  def convert_face_data

    # FCAVGDATA 의 Grade 2 와 3의 평균
    # min - max 는 AgeAll

  end

  def test
    # PR_1, PR_2
    # 1번 이마, 2번이 코, 3번
  end

  def test2
    #탄력 각도 ; EL_ANGLE_7 이 오른쪽 볼, 8이 왼쪽
  end
end
