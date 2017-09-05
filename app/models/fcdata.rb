require 'rubygems'
require 'composite_primary_keys'

class Fcdata < ApplicationRecord
  self.table_name = "fcdata" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial,:ch_cd,:measureno if Rails.env.production? || Rails.env.staging?

  # TZone 1 이마 2 코
  # UZone 7 오른쪽 볼 8 왼쪽 볼
  # 3 오른쪽 눈옆 4 오른쪽 눈밑 5 왼쪽 눈옆 6 왼쪽 눈밑

  def to_api_hash
    {
       custserial: custserial,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno.to_i,
       uptdate: uptdate,
       mo_1_origin: mo_1,
       mo_7_origin: mo_7,
       mo_8_origin: mo_8,
       mo_1: get_mo_to_five(value: mo_1),
       mo_7: get_mo_to_five(value: mo_7),
       mo_8: get_mo_to_five(value: mo_8),
       mo_avg: get_mo_avg,
       mo_graph: get_graph_mo,
       pr_1: pr_1,
       pr_2: pr_2,
       pr_7: pr_7,
       pr_8: pr_8,
       pr_avr: pr_avr,
       pr_graph: get_graph_data(type: "pore"),
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
       wr_graph_min: 0,
       wr_graph_max: 100,
       wr_graph_avr: get_vertical_graph_avr(type: "wr"),
       wr_graph_me: get_vertical_graph_me(type: "wr"),
       el_7: el_7,
       el_8: el_8,
       el_avr: el_avr,
       el_graph: get_graph_data(type: "el"),
       el_graph_min: 0,
       el_graph_max: 100,
       el_graph_avr: get_vertical_graph_avr(type: "el"),
       el_graph_me: get_vertical_graph_me(type: "el"),
       el_angle_7: el_angle_7,
       el_angle_8: el_angle_8,
       sb_1: sb_1,
       sb_2: sb_2,
       sb_7: sb_7,
       sb_8: sb_8,
       sb_avr: sb_avr,
       sb_graph: get_graph_data(type: "sb"),
       sb_graph_min: 0,
       sb_graph_max: 100,
       sb_graph_avr: get_vertical_graph_avr(type: "sb"),
       sb_graph_me: get_vertical_graph_me(type: "sb"),
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
       pp_graph_min: 0,
       pp_graph_max: 100,
       pp_graph_avr: get_vertical_graph_avr(type: "pp"),
       pp_graph_me: get_vertical_graph_me(type: "pp"),
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
       e_sebum_t: get_vertical_graph_me(type: "e_sebum_t"),
       e_sebum_t_graph_min: 0,
       e_sebum_t_graph_max: 100,
       e_sebum_t_graph_avr: get_vertical_graph_avr(type: "e_sebum_t"),
       e_sebum_t_graph_description: get_vertical_graph_description(type: "e_sebum_t"),
       e_sebum_u: get_vertical_graph_me(type: "e_sebum_u"),
       e_sebum_u_graph_min: 0,
       e_sebum_u_graph_max: 100,
       e_sebum_u_graph_avr: get_vertical_graph_avr(type: "e_sebum_u"),
       e_sebum_u_graph_description: get_vertical_graph_description(type: "e_sebum_u"),
       e_porphyrin_t: get_vertical_graph_me(type: "e_porphyrin_t"),
       e_porphyrin_t_graph_min: 0,
       e_porphyrin_t_graph_max: 100,
       e_porphyrin_t_graph_avr: get_vertical_graph_avr(type: "e_porphyrin_t"),
       e_porphyrin_t_graph_description: get_vertical_graph_description(type: "e_porphyrin_t"),
       e_porphyrin_u: get_vertical_graph_me(type: "e_porphyrin_u"),
       e_porphyrin_u_graph_min: 0,
       e_porphyrin_u_graph_max: 100,
       e_porphyrin_u_graph_avr: get_vertical_graph_avr(type: "e_porphyrin_u"),
       e_porphyrin_u_graph_description: get_vertical_graph_description(type: "e_porphyrin_u"),
       dry_t: get_vertical_graph_me(type: "dry_t"),
       dry_t_graph_min: 0,
       dry_t_graph_max: 100,
       dry_t_graph_avr: get_vertical_graph_avr(type: "moisture"),
       dry_u: get_vertical_graph_me(type: "dry_u"),
       dry_u_graph_min: 0,
       dry_u_graph_max: 100,
       dry_u_graph_avr: get_vertical_graph_avr(type: "moisture"),
       m_skintype: m_skintype,
       uf_1: uf_1,
       uf_2: uf_2,
       uf_3: uf_3,
       uf_4: uf_4,
       uf_5: uf_5,
       uf_6: uf_6,
       uf_7: uf_7,
       uf_8: uf_8,
       uf_avr: uf_avr,
       age: age,
       el_cnt_7: el_cnt_7,
       el_cnt_8: el_cnt_8,
       worry_skin_new_1: worry_skin_new_1,
       worry_skin_new_2: worry_skin_new_2
    }
  end

  def to_api_hash_for_admin
    {
       custserial: custserial,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno.to_i,
       uptdate: uptdate,
       pr_graph: get_graph_data(type: "pore"),
       wr_graph: get_graph_data(type: "wr"),
       el_graph: get_graph_data(type: "el"),
       sb_graph: get_graph_data(type: "sb"),
       pp_graph: get_graph_data(type: "pp"),
       mo_graph: get_graph_mo
    }
  end

  def to_api_hash_for_debug
    {
       custserial: custserial,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno.to_i,
       uptdate: uptdate,
       pr_graph: get_graph_data(type: "pore"),
       wr_graph: get_graph_data(type: "wr"),
       el_graph: get_graph_data(type: "el"),
       sb_graph: get_graph_data(type: "sb"),
       pp_graph: get_graph_data(type: "pp"),
       mo_graph: get_graph_mo,
       pr_graph_me: get_vertical_graph_me(type: "pore"),
       wr_graph_me: get_vertical_graph_me(type: "wr"),
       el_graph_me: get_vertical_graph_me(type: "el"),
       sb_graph_me: get_vertical_graph_me(type: "sb"),
       pp_graph_me: get_vertical_graph_me(type: "pp"),
       dry_t: get_vertical_graph_me(type: "dry_t"),
       dry_u: get_vertical_graph_me(type: "dry_u")
    }
  end

  def to_api_hash_for_yanus
    {
      custserial: custserial,
      measuredate: measuredate,
      measureno: measureno.to_i,
      shop_cd: shop_cd
    }
  end

  def api_hash_for_list_join_custinfo
    {
      custserial: custserial,
      custname: custinfo_custname(custserial: custserial),
      sex: custinfo_sex(custserial: custserial),
      birthyy: custinfo_birthyy(custserial: custserial),
      birthmm: custinfo_birthmm(custserial: custserial),
      birthdd: custinfo_birthdd(custserial: custserial),
      phone: custinfo_phone(custserial: custserial),
      measuredate: measuredate,
      measureno: measureno.to_i,
      shop_cd: shop_cd,
      m_skintype: m_skintype,
      colortype: colortype,
      skintype: skintype,
      worry_skin_1: worry_skin_1,
      worry_skin_2: worry_skin_2
    }
  end

  def custinfo_custname(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.custname.nil?
    return URI.decode(user.custname)
  end

  def custinfo_sex(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.sex.nil?
    return user.sex
  end

  def custinfo_birthyy(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.birthyy.nil?
    return user.birthyy
  end

  def custinfo_birthmm(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.birthmm.nil?
    return user.birthmm
  end

  def custinfo_birthdd(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.birthdd.nil?
    return user.birthdd
  end

  def custinfo_phone(custserial: nil)
    return "" if custserial.nil?
    user = Custinfo.where(custserial: custserial).first
    return "" if user.nil?
    return "" if user.phone.nil?
    return user.phone
  end

  #TZone 이마 수분 측정 평균값 : Moisture 본인값 : MO_1
  #UZone 양볼 수분 측정 평균값 : Moisture 본인값 : MO_7 / 8 의 평균

  #Vertical / Horizontal Graph
  def get_vertical_graph_min(type: nil)
    if type == "moisture"
      return Fcavgdata.where(age: "AgeALL_Min").first.moisture.to_f
    end

    if type == "e_sebum_t"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_sebum_t.to_f
    end

    if type == "e_sebum_u"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_sebum_u.to_f
    end

    if type == "e_porphyrin_t"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_t.to_f
    end

    if type == "e_porphyrin_u"
      return Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_u.to_f
    end

    if type == "pore"
      return Fcavgdata.where(age: "AgeALL_Min").first.pore.to_f
    end

    if type == "sb"
      # 트러블
      return (Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Min").first.e_porphyrin_t.to_f) / 2
    end

    if type == "wr"
      return Fcavgdata.where(age: "AgeALL_Min").first.wrinkle.to_f
    end

    if type == "el"
      return Fcavgdata.where(age: "AgeALL_Min").first.elasticity.to_f
    end

    if type == "pp"
      return Fcavgdata.where(age: "AgeALL_Min").first.spot_pl.to_f
    end
  end

  def get_vertical_graph_max(type: nil)
    if type == "moisture"
      return Fcavgdata.where(age: "AgeALL_Max").first.moisture.to_f
    end

    if type == "e_sebum_t"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_sebum_t.to_f
    end

    if type == "e_sebum_u"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_sebum_u.to_f
    end

    if type == "e_porphyrin_t"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_t.to_f
    end

    if type == "e_porphyrin_u"
      return Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_u.to_f
    end

    if type == "pore"
      return Fcavgdata.where(age: "AgeALL_Max").first.pore.to_f
    end

    if type == "sb"
      # 트러블
      return (Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Max").first.e_porphyrin_t.to_f) / 2
    end

    if type == "wr"
      return Fcavgdata.where(age: "AgeALL_Max").first.wrinkle.to_f
    end

    if type == "el"
      return Fcavgdata.where(age: "AgeALL_Max").first.elasticity.to_f
    end

    if type == "pp"
      return Fcavgdata.where(age: "AgeALL_Max").first.spot_pl.to_f
    end
  end

  def get_vertical_graph_me(type: nil)
    if self.custserial.nil?
      return 0
    end

    user = Custinfo.where(custserial: self.custserial).first
    age = Date.current.year - user.birthyy.to_i - 1
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")

    my_position = 0
    min_value = 0
    max_value = 100
    first_split_point = 33
    second_split_point = 66

    if type == "moisture"
      my_position = sp_pl_avr
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_f
    end

    if type == "dry_t"
      my_position = mo_1
      min_value = get_vertical_graph_min(type: "moisture")
      max_value = get_vertical_graph_max(type: "moisture")
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_f
    end

    if type == "dry_u"
      my_position = (mo_7 + mo_8) / 2 #25
      min_value = get_vertical_graph_min(type: "moisture")
      max_value = get_vertical_graph_max(type: "moisture")
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_f #28.0
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_f #38.0
    end

    if type == "e_sebum_t"
      my_position = e_sebum_t
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_t.to_f
    end

    if type == "e_sebum_u"
      my_position = e_sebum_u
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_u.to_f
    end

    if type == "e_porphyrin_t"
      my_position = e_porphyrin_t
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)

      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_t.to_f
    end

    if type == "e_porphyrin_u"
      my_position = e_porphyrin_u
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_u.to_f
    end

    if type == "pore"
      my_position = pr_avr
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.pore.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.pore.to_f
    end

    if type == "sb"
      my_position = (e_porphyrin_u.to_f + e_porphyrin_t.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = (Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_t.to_f) / 2
      second_split_point = (Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_t.to_f) / 2
    end

    if type == "wr"
      my_position = wr_avr
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.wrinkle.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.wrinkle.to_f
    end

    if type == "el"
      my_position = el_avr
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.elasticity.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.elasticity.to_f
    end

    if type == "pp"
      my_position = sp_pl_avr
      if ch_cd == "CNPR" || ch_cd == "RLAB"
        tabletinterviewrx = Fctabletinterviewrx.where(ch_cd: ch_cd).where(custserial: custserial).where(fcdata_id: measureno).first
        if !tabletinterviewrx.nil? && tabletinterviewrx.mmode == "Customer"
          Rails.logger.info "pp Customer!!!"
          my_position = sp_pl_avr+7
        end
      end

      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.spot_pl.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.spot_pl.to_f
    end

    tablet_ch_cd = "CNP"
    if !Fctabletinterviewrx.where(ch_cd: ch_cd).where(custserial: custserial).where(fcdata_id: measureno).first.nil?
      tablet_ch_cd = "CNPR"
    end

    return convert_graph_max_100(type: type, value: my_position, min_value: min_value, max_value: max_value, first_split_point: first_split_point, second_split_point: second_split_point, tablet_ch_cd: tablet_ch_cd)
  end

  def get_vertical_graph_avr(type: nil)
    if self.custserial.nil?
      return 0
    end

    user = Custinfo.where(custserial: self.custserial).first
    age = Date.current.year - user.birthyy.to_i - 1
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")

    age_avr = 0
    min_value = 0
    max_value = 100
    first_split_point = 33
    second_split_point = 66

    if type == "moisture"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.moisture.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.moisture.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_f
    end

    if type == "e_sebum_t"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_t.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_t.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_t.to_f
    end

    if type == "e_sebum_u"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_u.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_u.to_f
    end

    if type == "e_porphyrin_t"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_t.to_f
    end

    if type == "e_porphyrin_u"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_u.to_f
    end

    if type == "pore"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.pore.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.pore.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.pore.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.pore.to_f
    end

    if type == "sb"
      avr_e_porphyrin_u = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_f) / 2
      avr_e_porphyrin_t = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_f) / 2
      age_avr = (avr_e_porphyrin_u + avr_e_porphyrin_t) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = (Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_t.to_f ) / 2
      second_split_point = (Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_u.to_f + Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_t.to_f ) / 2
    end

    if type == "wr"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.wrinkle.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.wrinkle.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.wrinkle.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.wrinkle.to_f
    end

    if type == "el"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.elasticity.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.elasticity.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.elasticity.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.elasticity.to_f
    end

    if type == "pp"
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.spot_pl.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.spot_pl.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.spot_pl.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.spot_pl.to_f
    end

    tablet_ch_cd = "CNP"
    if !Fctabletinterviewrx.where(ch_cd: ch_cd).where(custserial: custserial).where(fcdata_id: measureno).first.nil?
      tablet_ch_cd = "CNPR"
    end

    return convert_graph_max_100(type: type, value: age_avr, min_value: min_value, max_value: max_value, first_split_point: first_split_point, second_split_point: second_split_point, is_avr: true, tablet_ch_cd: tablet_ch_cd)
  end

  def get_vertical_graph_description(type: nil)
    if self.custserial.nil?
      return 0
    end

    user = Custinfo.where(custserial: self.custserial).first
    age = Date.current.year - user.birthyy.to_i - 1
    avg_grade_1_field_name = generate_age_data_field(age: age).concat("1")
    avg_grade_2_field_name = generate_age_data_field(age: age).concat("2")
    avg_grade_3_field_name = generate_age_data_field(age: age).concat("3")
    avg_grade_4_field_name = generate_age_data_field(age: age).concat("4")

    my_position = 0
    age_avr = 0
    min_value = 0
    max_value = 100
    first_split_point = 33
    second_split_point = 66

    description = ""
    description << type
    description << "은 "

    if type.to_s == "e_sebum_t"
      my_position = e_sebum_t
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_t.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_t.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_t.to_f
    end

    if type.to_s == "e_sebum_u"
      my_position = e_sebum_u
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_sebum_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_sebum_u.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_sebum_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_sebum_u.to_f
    end

    if type.to_s == "e_porphyrin_t"
      my_position = e_porphyrin_t
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_t.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_t.to_f
    end

    if type.to_s == "e_porphyrin_u"
      my_position = e_porphyrin_u
      age_avr = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_f) / 2
      min_value = get_vertical_graph_min(type: type)
      max_value = get_vertical_graph_max(type: type)
      first_split_point = Fcavgdata.where(age: "AgeALL_Grade2").first.e_porphyrin_u.to_f
      second_split_point = Fcavgdata.where(age: "AgeALL_Grade3").first.e_porphyrin_u.to_f
    end

    description << "평균값은 "
    description << age_avr.to_s
    description << " First Split point는 "
    description << first_split_point.to_s
    description << " Second Split point는 "
    description << second_split_point.to_s
    description << " // 나의 값은 "
    description << my_position.to_f.to_s
    description
  end

  def convert_graph_max_100(type: nil, value: nil, first_split_point: nil, second_split_point: nil, min_value: nil, max_value: nil, is_avr: false, tablet_ch_cd: nil)
    Rails.logger.info "convert_graph_max_100!!"
    Rails.logger.info tablet_ch_cd
    Rails.logger.info is_avr
    Rails.logger.info type
    Rails.logger.info value
    Rails.logger.info min_value
    Rails.logger.info first_split_point
    Rails.logger.info second_split_point
    Rails.logger.info max_value

    if value.to_f < first_split_point.to_f
      denominator = (first_split_point.to_f - min_value.to_f)
      denominator = 1 if denominator == 0
      value = ((value.to_f - min_value.to_f) / denominator) * 32.3
    elsif value.to_f >= first_split_point.to_f && value.to_f < second_split_point.to_f
      denominator = (second_split_point.to_f - first_split_point.to_f)
      denominator = 1 if denominator == 0
      value = (((value.to_f - first_split_point.to_f) / denominator) * 33.3) + 33.3
    elsif value.to_f >= second_split_point.to_f
      denominator = (max_value.to_f - second_split_point.to_f)
      denominator = 1 if denominator == 0
      value = (((value.to_f - second_split_point.to_f) / denominator) * 33.3) + 66.6
    end

    Rails.logger.info value

    if value > 99.9
      value = 99.9
    end
    if tablet_ch_cd != "CNP"
      if type != 'moisture' && type != 'dry_t' && type != 'dry_u'
        value = 99.9 - value
      end
      if value <= 32.3
        value = value + 1
      end
      value = (value * 0.85) + 15
    else
      if type != 'moisture' && type != 'pore' && type != 'sb' && type != 'pp' && type != 'dry_t' && type != 'dry_u'
        value = 99.9 - value
      end
    end

    Rails.logger.info value

    # if (type == 'pore' || type == 'sb' || type == 'wr' || type == 'el' || type == 'pp') && !is_avr
    #   if get_graph_data(type: type) == 2
    #     value = get_vertical_graph_avr(type: type)
    #   end
    # end
    return value
  end

  def get_graph_data(type: nil)
    # 수분은 높을 수록 좋은 것
    if self.custserial.nil?
      return 0
    end
    user = Custinfo.where(custserial: self.custserial).first
    age = Date.current.year - user.birthyy.to_i - 1

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
      avr = (self.e_porphyrin_u.to_f + self.e_porphyrin_t.to_f) / 2
      avr1 = (Fcavgdata.where(age: avg_grade_1_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_1_field_name).first.e_porphyrin_t.to_f) / 2
      avr2 = (Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_2_field_name).first.e_porphyrin_t.to_f) / 2
      avr3 = (Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_3_field_name).first.e_porphyrin_t.to_f) / 2
      avr4 = (Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_u.to_f + Fcavgdata.where(age: avg_grade_4_field_name).first.e_porphyrin_t.to_f) / 2

      return convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    end

    if type == "pp"
      # 색소침착 SPOT_PL
      avr = self.sp_pl_avr
      if ch_cd == "CNPR" || ch_cd == "RLAB"
        tabletinterviewrx = Fctabletinterviewrx.where(ch_cd: self.ch_cd).where(custserial: self.custserial).where(fcdata_id: self.measureno).first
        if !tabletinterviewrx.nil? && tabletinterviewrx.mmode == "Customer"
          Rails.logger.info "pp Customer!!!"
          avr = self.sp_pl_avr+7
        end
      end
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

  def get_mo_avg
    return ((self.mo_1.to_f + self.mo_7.to_f + self.mo_8.to_f) / 3).round
  end

  def get_graph_mo
    # 수분은 높을 수록 좋은 것
    if self.custserial.nil?
      return 0
    end

    avr = ((self.mo_1.to_f + self.mo_7.to_f + self.mo_8.to_f) / 3).round
    if ch_cd == "CNPR" || ch_cd == "RLAB"
      tabletinterviewrx = Fctabletinterviewrx.where(ch_cd: ch_cd).where(custserial: custserial).where(fcdata_id: measureno).first
      if !tabletinterviewrx.nil? && tabletinterviewrx.mmode == "Customer"
        avr = ((self.mo_1.to_f + self.mo_7.to_f + self.mo_8.to_f) / 3).round + 4
      end
    end

    avr1 = Fcavgdata.where(age: "AgeALL_Grade1").first.moisture.to_i
    avr2 = Fcavgdata.where(age: "AgeALL_Grade2").first.moisture.to_i
    avr3 = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_i
    avr4 = Fcavgdata.where(age: "AgeALL_Grade4").first.moisture.to_i

    if avr > avr4
      return 4
    end

    if avr > avr3 && avr <= avr4
      return 3
    end

    if avr >= avr2 && avr <= avr3
      return 2
    end

    if avr >= avr1 && avr < avr2
      return 1
    end

    if avr < avr1
      return 0
    end
  end

  def convert_avg_to_five(avr: avr, avr1: avr1, avr2: avr2, avr3: avr3, avr4: avr4)
    #avr2 = 0.3 / avr3 = 0.7
    if avr < avr1
      return 4
    end

    if avr >= avr1 && avr < avr2
      return 3
    end

    if avr >= avr2 && avr <= avr3
      return 2
    end

    if avr > avr3 && avr <= avr4
      return 1
    end

    if avr > avr4
      return 0
    end

    return 0
  end

  def generate_age_data_field(age: age)
    field_name = "Age"
    if age.to_i <= 10
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
    high = Fcavgdata.where(age: "AgeALL_Grade3").first.moisture.to_i

    if value.to_i < low
      return 0
    end

    if value.to_i >= low && value.to_i <= high
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

  def self.list(custserial: nil)
    scoped = Fcdata.all
    scoped = scoped.where(custserial: custserial) if custserial.present?
    scoped.order('measureno DESC')
  end

  def self.fcdata_month_list(shop_cd: nil, measuredate: nil)
    scoped = Fcdata.all
    scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
    scoped = scoped.where("measuredate LIKE ?", "%#{measuredate}%") if measuredate.present?
    scoped.order('measuredate ASC')
  end
end
