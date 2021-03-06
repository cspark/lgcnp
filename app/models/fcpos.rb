class Fcpos < ApplicationRecord
  self.table_name = "fcpos" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial,:measureno if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      custserial: custserial,
      faceno: faceno,
      measuredate: measuredate,
      measureno: measureno,
      uptdate: uptdate,
      fh_x: fh_x,
      fh_y: fh_y,
  	  fh_w: fh_w,
  		fh_h: fh_h,
    	ns_x: ns_x,
  		ns_y: ns_y,
    	ns_w: ns_w,
    	ns_h: ns_h,
  		res_x: res_x,
  	  res_y: res_y,
    	res_w: res_w,
  		res_h: res_h,
  		reu_x: reu_x,
  		reu_y: reu_y,
  		reu_w: reu_w,
    	reu_h: reu_h,
  		les_x: les_x,
  		les_y: les_y,
  		les_w: les_w,
  		les_h: les_h,
  		leu_x: leu_x,
  		leu_y: leu_y,
   	  leu_w: leu_w,
    	leu_h: leu_h,
      rs_x: rs_x,
    	rs_y: rs_y,
    	rs_w: rs_w,
    	rs_h: rs_h,
    	ls_x: ls_x,
    	ls_y: ls_y,
    	ls_w: ls_w,
      ls_h: ls_h,
    	rt_re_l: rt_re_l,
    	rt_re_t: rt_re_t,
    	rt_re_r: rt_re_r,
    	rt_re_b: rt_re_b,
    	rt_le_l: rt_le_l,
    	rt_le_t: rt_le_t,
    	rt_le_r: rt_le_r,
    	rt_le_b: rt_le_b,
    	rt_lip_l: rt_lip_l,
      rt_lip_t: rt_lip_t,
    	rt_lip_r: rt_lip_r,
    	rt_lip_b: rt_lip_b,
    	rt_res_x: rt_res_x,
   	  rt_res_y: rt_res_y,
    	rt_les_x: rt_les_x,
    	rt_les_y: rt_les_y,
      shop_cd: shop_cd,
      rt_face_l: rt_face_l,
      rt_face_t: rt_face_t,
      rt_face_r: rt_face_r,
      rt_face_b: rt_face_b
    }
  end

  def self.list(custserial: nil, measureno: nil)
    scoped = Fcpos.all
    scoped = scoped.where(custserial: custserial) if custserial.present?
    scoped = scoped.where(measureno: measureno) if measureno.present?
    scoped.order('measureno DESC')
  end
end
