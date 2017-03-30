class Fcshop < ApplicationRecord
self.table_name = "fcshop" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      shop_cd: shop_cd,
      shop_name: shop_name,
      ch_cd: ch_cd
    }
  end

  def self.list(shop_cd: nil)
    scoped = Fcshop.all
    scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
    scoped.order('shop_cd asc')
  end
end
