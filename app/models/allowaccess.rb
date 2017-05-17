class Allowaccess < ApplicationRecord
  self.table_name = "allowaccess" if Rails.env.production? || Rails.env.staging?

  def update_ip(low_ip: nil, high_ip: nil)
    self.low_ip = low_ip
    self.high_ip = high_ip
  end
end
