class Privacyaccesshistory < ApplicationRecord
  self.table_name = "Privacyaccesshistory" if Rails.env.production? || Rails.env.staging?
end
