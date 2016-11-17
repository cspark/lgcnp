class Fcpos < ApplicationRecord
  def to_api_hash
    {
      custserial: self.CUSTSERIAL,
      faceno: self.FACENO,
      measuredate: self.MEASUREDATE,
      measureno: self.MEASURENO,
      uptdate: self.UPTDATE,
      fh_x: self.FH_X,
      fh_y: self.FH_Y,
  	  fh_w: self.FH_W,
  		fh_h: self.FH_H,
    	ns_x: self.NS_X,
  		ns_y: self.NS_Y,
    	ns_w: self.NS_W,
    	ns_h: self.NS_H,
  		res_x: self.RES_X,
  	  res_y: self.RES_Y,
    	res_w: self.RES_W,
  		res_h: self.RES_H,
  		reu_x: self.REU_X,
  		reu_y: self.REU_Y,
  		reu_w: self.REU_W,
    	reu_h: self.REU_H,
  		les_x: self.LES_X,
  		les_y: self.LES_Y,
  		les_w: self.LES_W,
  		les_h: self.LES_H,
  		leu_x: self.LEU_X,
  		leu_y: self.LEU_Y,
   	  leu_w: self.LEU_W,
    	leu_h: self.LEU_H,
      rs_x: self.RS_X,
    	rs_y: self.RS_Y,
    	rs_w: self.RS_W,
    	rs_h: self.RS_H,
    	ls_x: self.LS_X,
    	ls_y: self.LS_Y,
    	ls_w: self.LS_W,
      ls_h: self.LS_H,
    	rt_re_l: self.RT_RE_L,
    	rt_re_t: self.RT_RE_T,
    	rt_re_r: self.RT_RE_R,
    	rt_re_b: self.RT_RE_B,
    	rt_le_l: self.RT_LE_L,
    	rt_le_t: self.RT_LE_T,
    	rt_le_r: self.RT_LE_R,
    	rt_le_b: self.RT_LE_B,
    	rt_lip_l: self.RT_LIP_L,
      rt_lip_t: self.RT_LIP_T,
    	rt_lip_r: self.RT_LIP_R,
    	rt_lip_b: self.RT_LIP_B,
    	rt_res_x: self.RT_RES_X,
   	  rt_res_y: self.RT_RES_Y,
    	rt_les_x: self.RT_LES_X,
    	rt_les_y: self.RT_LES_Y,
    }
  end

  def input_random_number
    self.FH_X = SecureRandom.random_number(5)
    self.FH_Y = SecureRandom.random_number(5)
    self.FH_W = SecureRandom.random_number(5)
    self.FH_H = SecureRandom.random_number(5)
    self.NS_X = SecureRandom.random_number(5)
    self.NS_Y = SecureRandom.random_number(5)
    self.NS_W = SecureRandom.random_number(5)
    self.NS_H = SecureRandom.random_number(5)
    self.RES_X = SecureRandom.random_number(5)
    self.RES_Y = SecureRandom.random_number(5)
    self.RES_W = SecureRandom.random_number(5)
    self.RES_H = SecureRandom.random_number(5)
    self.REU_X = SecureRandom.random_number(5)
    self.REU_Y = SecureRandom.random_number(5)
    self.REU_W = SecureRandom.random_number(5)
    self.REU_H = SecureRandom.random_number(5)
    self.LES_X = SecureRandom.random_number(5)
    self.LES_Y = SecureRandom.random_number(5)
    self.LES_W = SecureRandom.random_number(5)
    self.LES_H = SecureRandom.random_number(5)
    self.LEU_X = SecureRandom.random_number(5)
    self.LEU_Y = SecureRandom.random_number(5)
    self.LEU_W = SecureRandom.random_number(5)
    self.LEU_H = SecureRandom.random_number(5)
    self.RS_X = SecureRandom.random_number(5)
    self.RS_Y = SecureRandom.random_number(5)
    self.RS_W = SecureRandom.random_number(5)
    self.RS_H = SecureRandom.random_number(5)
    self.LS_X = SecureRandom.random_number(5)
    self.LS_Y = SecureRandom.random_number(5)
    self.LS_W = SecureRandom.random_number(5)
    self.LS_H = SecureRandom.random_number(5)
    self.RT_RE_L = SecureRandom.random_number(5)
    self.RT_RE_T = SecureRandom.random_number(5)
    self.RT_RE_R = SecureRandom.random_number(5)
    self.RT_RE_B = SecureRandom.random_number(5)
    self.RT_LE_L = SecureRandom.random_number(5)
    self.RT_LE_T = SecureRandom.random_number(5)
    self.RT_LE_R = SecureRandom.random_number(5)
    self.RT_LE_B = SecureRandom.random_number(5)
    self.RT_LIP_L = SecureRandom.random_number(5)
    self.RT_LIP_T = SecureRandom.random_number(5)
    self.RT_LIP_R = SecureRandom.random_number(5)
    self.RT_LIP_B = SecureRandom.random_number(5)
    self.RT_RES_X = SecureRandom.random_number(5)
    self.RT_RES_Y = SecureRandom.random_number(5)
    self.RT_LES_X = SecureRandom.random_number(5)
    self.RT_LES_Y = SecureRandom.random_number(5)
  end
end
