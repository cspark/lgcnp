class Custinfo < ApplicationRecord
  self.table_name = "custinfo" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial if Rails.env.production? || Rails.env.staging?


  def self.list(n_cust_id: nil, page: 1, per: 3)
    scoped = Custinfo.all
    scoped = scoped.where(n_cust_id: n_cust_id) if n_cust_id.present?
    scoped.order('updated_at DESC').page(page).per(per)
  end

  def to_api_hash
    {
      serial: custserial,
      ch_cd: ch_cd,
      n_cust_id: n_cust_id,
      measureno: measureno,
      custname: custname,
      sex: sex,
      age: age,
      birthyy: birthyy,
      birthmm: birthmm,
      birthdd: birthdd,
      phone: phone,
      update: uptdate,
      lastanaldate: lastanaldate,
      is_agree_privacy: is_agree_privacy,
      is_agree_thirdparty_info: is_agree_thirdparty_info,
      is_agree_marketing: is_agree_marketing,
      is_agree_after: is_agree_after
    }
  end

  def increase_measureno
    self.measureno = (self.measureno.to_i + 1).to_s
  end

  def update_lastanaldate
    yymmdd = Time.now.to_s.split(" ")[0]
    temp_date = Time.now.to_s.split(" ")[1]
    hhmmss = temp_date.split(":")[0] + "-" +temp_date.split(":")[1]+ "-" +temp_date.split(":")[2]
    self.lastanaldate = yymmdd+ "-" +hhmmss
  end

  def decode_name
    custname
  end
end
