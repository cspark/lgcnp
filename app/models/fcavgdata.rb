class Fcavgdata < ApplicationRecord
  self.table_name = "fcavgdata" if Rails.env.production? || Rails.env.staging?
end
