class Privacyaccesshistory < ApplicationRecord
  self.table_name = "privacyaccesshistory" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :id if Rails.env.production? || Rails.env.staging?
end
