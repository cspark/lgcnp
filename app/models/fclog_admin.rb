class FclogAdmin < ApplicationRecord
  self.table_name = "fclog_admin" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      admin_id: admin_id,
      ip: ip,
      log_date: log_date,
      work_name: work_name,
      work_comment: work_comment
    }
  end
end
