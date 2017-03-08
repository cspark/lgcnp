class Fcschedule < ApplicationRecord
  self.table_name = "fcschedule" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      ch_cd: ch_cd,
      shop_cd: shop_cd,
      reserve_yyyy: reserve_yyyy,
      reserve_mmdd: reserve_mmdd,
      reserve_hhmm: reserve_hhmm,
      custname: custname,
      phone: phone,
      reserve_yn: reserve_yn,
      memo: memo,
      uptdate: uptdate,
      purchase_yn: purchase_yn
    }
  end
end
