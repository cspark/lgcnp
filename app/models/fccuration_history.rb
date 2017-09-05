class FccurationHistory < ApplicationRecord
  self.table_name = "fccuration_history" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :upload_date,:version_name if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      upload_date: upload_date,
      version_name: version_name,
      cura_entry_filename: cura_entry_filename,
      cura_comment: cura_comment
    }
  end
end
