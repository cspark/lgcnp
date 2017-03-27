class Fcmodecnt < ApplicationRecord
  self.table_name = "fcmodecnt" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :modecnt_serial if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
       modecnt_serial: modecnt_serial,
       shop_cd: shop_cd,
       ch_cd: ch_cd,
       analdate: analdate,
       mode_name: mode_name
     }
   end

   def self.list(shop_cd: nil, ch_cd: nil, mode_name: nil, analdate: nil)
     scoped = Fcmodecnt.all
     scoped = scoped.where(shop_cd: shop_cd) if shop_cd.present?
     scoped = scoped.where(ch_cd: ch_cd) if ch_cd.present?
     scoped = scoped.where("mode_name LIKE ?", mode_name) if mode_name.present?
     scoped = scoped.where("analdate LIKE ?", "%#{analdate}%") if analdate.present?
     scoped.order('modecnt_serial DESC')
   end
end
