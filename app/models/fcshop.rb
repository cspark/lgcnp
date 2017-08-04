class Fcshop < ApplicationRecord
self.table_name = "fcshop" if Rails.env.production? || Rails.env.staging?
self.primary_key = :shop_cd, :shop_name if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      shop_cd: shop_cd,
      shop_name: shop_name,
      ch_cd: ch_cd,
      tel_no: tel_no,
      address: address
    }
  end

  def self.list(shop_cd: nil, shop_name: nil, ch_cd: nil, tel_no: nil, address: nil)
    scoped = Fcshop.all
    scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
    scoped = scoped.where(shop_name: shop_name) if shop_name.present?
    scoped = scoped.where(ch_cd: ch_cd) if ch_cd.present?
    scoped = scoped.where(tel_no: tel_no) if tel_no.present?
    scoped = scoped.where(address: address) if address.present?
    scoped.order('created_at DESC')
  end
end
