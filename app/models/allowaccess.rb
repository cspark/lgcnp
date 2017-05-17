class Allowaccess < ApplicationRecord
  self.table_name = "allowaccess" if Rails.env.production? || Rails.env.staging?

  def update_ip(low_ip: nil, high_ip: nil)
    Rails.logger.info low_ip
    Rails.logger.info high_ip
    self.low_ip = low_ip
    self.high_ip = high_ip
    self.save
  end
end
