require 'rmagick'
class AdminFcdata < ApplicationRecord
  self.table_name = "fcdata"

  def to_api_hash
    {
       custserial: custserial,
       ch_cd: ch_cd,
       faceno: faceno,
       measuredate: measuredate,
       measureno: measureno.to_i,
       uptdate: uptdate,
       mo_1: mo_1,
       mo_7: mo_7,
       mo_8: mo_8,
       pr_1: pr_1,
       pr_2: pr_2,
       pr_7: pr_7,
       pr_8: pr_8,
       pr_avr: pr_avr,
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
       e_sebum_t: e_sebum_t,
       e_sebum_u: e_sebum_u,
       e_porphyrin_t: e_porphyrin_t,
       e_porphyrin_u: e_porphyrin_u,
       m_skintype: m_skintype,
       janus_status: janus_status,
       shop_cd: shop_cd
    }
  end

  def self.list(custserial: nil)
    scoped = AdminFcdata.all
    scoped = scoped.where(custserial: custserial) if custserial.present?
    scoped.order('measureno DESC')
  end

  def self.image_combine(relation: nil, path: nil, type: nil)
    image_list = Magick::ImageList.new
    i = 1
    1.upto(2) {|x|
      new_image = Magick::ImageList.new
      1.upto(2) {|y|
        new_image.push(Magick::Image.read("public/"+relation.ch_cd+"/"+path+type+i.to_s+".jpg").first)
        i += 1
      }
      image_list.push(new_image.append(false))
    }
    image_list.append(true).write("public/"+relation.ch_cd+"/"+path+"Sym_L_merge.jpg")
  end
end
