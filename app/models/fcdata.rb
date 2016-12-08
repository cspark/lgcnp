class Fcdata < ApplicationRecord
  self.table_name = "fcdata"

  def to_api_hash
    {
       custserial: custserial,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno,
       uptdate: uptdate,
       mo_1: mo_1,
       mo_7: mo_7,
       mo_8: mo_8,
       pr_1: pr_1,
       pr_2: pr_2,
       pr_7: pr_7,
       pr_8: pr_8,
       pr_avr: pr_avr,
       pr_graph: get_graph_data(type: "pore"),
       wr_3: wr_3,
       wr_4: wr_4,
       wr_5: wr_5,
       wr_6: wr_6,
       wr_avr: wr_avr,
       wr_graph: get_graph_data(type: "wr"),
       el_7: el_7,
       el_8: el_8,
       el_avr: el_avr,
       el_graph: get_graph_data(type: "el"),
       el_angle_7: el_angle_7,
       el_angle_8: el_angle_8,
       sb_1: sb_1,
       sb_2: sb_2,
       sb_7: sb_7,
       sb_8: sb_8,
       sb_avr: sb_avr,
       sb_graph: get_graph_data(type: "sb"),
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
       score_r: score_r,
       score_l: score_l,
    }
  end

  def get_graph_data(type: nil)
    # 5가지 그래프 값 도출
    # FCAVGDATA 의 나이연령대별 평균  / UV 가 아닌  PL 값으로 판별
    # FCDATA 의 평균값
    # FCAVGDAT 의 나이연령대별 평균의 Grade 를 가지고 1~5점을 판별

    # 수분은 높을 수록 좋은 것
    user = Custinfo.where(custserial: self.custserial).first
    age = user.age

    avg_field_name = generate_age_data_field(age: age)

    avg_grade_1_field_name = avg_field_name.concat("1")
    avg_grade_2_field_name = avg_field_name.concat("2")
    avg_grade_3_field_name = avg_field_name.concat("3")
    avg_grade_4_field_name = avg_field_name.concat("4")
    if type == "pore"
      avr = self.pr_avr
      avr_1 = Fcavgdata.where(age: avg_grade_1_field_name).first.pore.to_i
      avr_2 = Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_i
      avr_3 = Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_i
      avr_4 = Fcavgdata.where(age: avg_grade_4_field_name).first.pore.to_i

      return convert_avg_to_five(avr: avr)
    end

    if type == "wr"
      avr = self.wr_avr
      avr_1 = Fcavgdata.where(age: avg_grade_1_field_name).first.wrinkle.to_i
      avr_2 = Fcavgdata.where(age: avg_grade_2_field_name).first.wrinkle.to_i
      avr_3 = Fcavgdata.where(age: avg_grade_3_field_name).first.wrinkle.to_i
      avr_4 = Fcavgdata.where(age: avg_grade_4_field_name).first.wrinkle.to_i

      return convert_avg_to_five(avr: avr)
    end

    if type == "el"
      avr = self.wr_avr
      avr_1 = Fcavgdata.where(age: avg_grade_1_field_name).first.elasticity.to_i
      avr_2 = Fcavgdata.where(age: avg_grade_2_field_name).first.elasticity.to_i
      avr_3 = Fcavgdata.where(age: avg_grade_3_field_name).first.elasticity.to_i
      avr_4 = Fcavgdata.where(age: avg_grade_4_field_name).first.elasticity.to_i

      return convert_avg_to_five(avr: avr)
    end

    if type == "sb"
      avr = self.wr_avr
      avr_1 = Fcavgdata.where(age: avg_grade_1_field_name).first.porphyrin_ratio.to_i
      avr_2 = Fcavgdata.where(age: avg_grade_2_field_name).first.porphyrin_ratio.to_i
      avr_3 = Fcavgdata.where(age: avg_grade_3_field_name).first.porphyrin_ratio.to_i
      avr_4 = Fcavgdata.where(age: avg_grade_4_field_name).first.porphyrin_ratio.to_i

      return convert_avg_to_five(avr: avr)
    end

    if type == "pp"
      avr = self.wr_avr
      avr_1 = Fcavgdata.where(age: avg_grade_1_field_name).first.porphyrin_ratio.to_i
      avr_2 = Fcavgdata.where(age: avg_grade_2_field_name).first.porphyrin_ratio.to_i
      avr_3 = Fcavgdata.where(age: avg_grade_3_field_name).first.porphyrin_ratio.to_i
      avr_4 = Fcavgdata.where(age: avg_grade_4_field_name).first.porphyrin_ratio.to_i

      return convert_avg_to_five(avr: avr)
    end
  end

  def convert_avg_to_five(avr: avr)
    if avr < avr_1
      return 1
    end

    if avr > avr_1 && avr < avr_2
      return 2
    end

    if avr > avr_2 && avr < avr_3
      return 3
    end

    if avr > avr_3 && avr < avr_4
      return 4
    end

    if avr > avr_4
      return 5
    end
  end

  def generate_age_data_field(age: age)
    field_name = "Age"
    if age.to_i < 10
      field_name.concat("1-10_Grade")
    end

    if age.to_i > 10 && age.to_i < 16
      field_name.concat("11-15_Grade")
    end

    if age.to_i > 15 && age.to_i < 21
      field_name.concat("16-20_Grade")
    end

    if age.to_i > 20 && age.to_i < 26
      field_name.concat("21-25_Grade")
    end

    if age.to_i > 25 && age.to_i < 31
      field_name.concat("26-30_Grade")
    end

    if age.to_i > 30 && age.to_i < 36
      field_name.concat("31-35_Grade")
    end

    if age.to_i > 35 && age.to_i < 41
      field_name.concat("36-40_Grade")
    end

    if age.to_i > 40 && age.to_i < 46
      field_name.concat("41-45_Grade")
    end

    if age.to_i > 45 && age.to_i < 51
      field_name.concat("46-50_Grade")
    end

    if age.to_i > 50 && age.to_i < 56
      field_name.concat("51-55_Grade")
    end

    if age.to_i > 55 && age.to_i < 61
      field_name.concat("56-60_Grade")
    end

    if age.to_i > 60 && age.to_i < 71
      field_name.concat("61-70_Grade")
    end

    if age.to_i > 70
      field_name.concat("71_Grade")
    end
  end

  def get_mo_data
    # AVG Data 의 Moisture Grade 3, 2 번을 참고
  end

  def get_averaget_graph
    # FCAVGDATA 의 Grade 2 와 3의 평균
    # min - max 는 AgeAll
  end

  def test
    # PR_1, PR_2
    # 1번 이마, 2번이 코, 3번ㅇ
  end

  def test2
    #탄력 각도 ; EL_ANGLE_7 이 오른쪽 볼, 8이 왼쪽

  end
end
