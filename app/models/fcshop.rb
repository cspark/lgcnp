class Fcshop < ApplicationRecord
self.table_name = "fcshop" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      shop_cd: shop_cd,
      shop_name: shop_name,
      ch_cd: ch_cd
    }
  end
end
