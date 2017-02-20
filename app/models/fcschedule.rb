class Fcschedule < ApplicationRecord
  self.table_name = "fcschedule" if Rails.env.production? || Rails.env.staging?
end
