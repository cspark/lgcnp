class FcnoticeHistory < ApplicationRecord
  self.table_name = "fcnotice_history" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :upload_date if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      upload_date: upload_date,
      begin_date: begin_date,
      end_date: end_date,
      file_name: file_name,
      notice_comment: notice_comment,
      ch_cd: ch_cd
    }
  end

  def self.list(ch_cd: nil)
    scoped = FcnoticeHistory.all
    scoped = scoped.where(ch_cd: ch_cd) if ch_cd.present?
    scoped.order("end_date desc")
  end
end
