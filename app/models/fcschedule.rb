class Fcschedule < ApplicationRecord
  self.table_name = "fcschedule" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :ch_cd,:shop_cd,:reserve_yyyy,:reserve_mmdd, :reserve_hhmm if Rails.env.production? || Rails.env.staging?

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

  def self.month_list(ch_cd: nil, shop_cd: nil, reserve_yyyy: nil, reserve_mm: nil)
    scoped = Fcschedule.all
    scoped = scoped.where(ch_cd: ch_cd) if ch_cd.present?
    scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
    scoped = scoped.where(reserve_yyyy: reserve_yyyy) if reserve_yyyy.present?
    scoped = scoped.where("reserve_mmdd LIKE ?", "#{reserve_mm}%") if reserve_mm.present?
    scoped.order('reserve_mmdd ASC')
  end

  def self.list(ch_cd: nil, shop_cd: nil, reserve_yyyy: nil, reserve_mmdd: nil, reserve_hhmm: nil, phone: nil)
    scoped = Fcschedule.all
    scoped = scoped.where(ch_cd: ch_cd) if ch_cd.present?
    scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
    scoped = scoped.where(reserve_yyyy: reserve_yyyy) if reserve_yyyy.present?
    scoped = scoped.where(reserve_mmdd: reserve_mmdd) if reserve_mmdd.present?
    scoped = scoped.where(reserve_hhmm: reserve_hhmm) if reserve_hhmm.present?
    scoped = scoped.where(phone: phone) if phone.present?
    scoped.order('reserve_mmdd ASC')
  end
end
