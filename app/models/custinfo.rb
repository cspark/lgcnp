require 'uri'
class Custinfo < ApplicationRecord
  self.table_name = "custinfo" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial if Rails.env.production? || Rails.env.staging?

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
      is_agree_after: is_agree_after,
      address: address
    }
  end

  def to_api_hash_for_yanus
    {
      custserial: custserial,
      ch_cd: ch_cd,
      n_cust_id: n_cust_id,
      measureno: measureno.to_i.to_s,
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
      is_agree_after: is_agree_after,
      address: address
    }
  end

  def to_api_hash_for_min
    {
      custserial: custserial,
      ch_cd: ch_cd,
      n_cust_id: n_cust_id,
      measureno: measureno.to_s
    }
  end

  def increase_measureno
    self.measureno = (self.measureno.to_i + 1).to_s
  end

  def update_lastanaldate
    change_time_now = Time.now + 10.minute - 18.seconds
    yymmdd = change_time_now.to_s.split(" ")[0]
    temp_date = change_time_now.strftime("%H:%M:%S").to_s
    hhmmss = temp_date.split(":")[0]+"-"+temp_date.split(":")[1]+"-"+temp_date.split(":")[2]
    self.lastanaldate = yymmdd+ "-" +hhmmss
  end

  def decode_name
    custname
  end

  def self.to_csv(options = {}, users)
    CSV.generate(options) do |csv|
      csv << column_names
      users.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
