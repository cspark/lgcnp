class Allowaccess < ApplicationRecord
  self.table_name = "allowaccess" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :low_ip,:high_ip if Rails.env.production? || Rails.env.staging?
end
