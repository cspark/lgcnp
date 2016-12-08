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
       pr_avr: get_graph_data(pore),
       wr_3: wr_3,
       wr_4: wr_4,
       wr_5: wr_5,
       wr_6: wr_6,
       wr_avr: wr_avr,
       el_7: el_7,
       el_8: el_8,
       el_avr: el_avr,
       el_angle_7: el_angle_7,
       el_angle_8: el_angle_8,
       sb_1: sb_1,
       sb_2: sb_2,
       sb_7: sb_7,
       sb_8: sb_8,
       sb_avr: sb_avr,
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

    if type == "pore"
      
    end
  end

  def get_mo_data
    # AVG Data 의 Moisture Grade 3, 2 번을 참고
  end

  def get_averaget_graph
    # FCAVGDATA 의 Grade 2 와 3의 평균
    # min - max 는 AgeAll
  end

  def
    # PR_1, PR_2
    # 1번 이마, 2번이 코, 3번ㅇ
  end

  def
    #탄력 각도 ; EL_ANGLE_7 이 오른쪽 볼, 8이 왼쪽

  end

  end
end
