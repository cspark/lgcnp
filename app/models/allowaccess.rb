class Allowaccess < ApplicationRecord
  self.table_name = "allowaccess" if Rails.env.production? || Rails.env.staging?
end
