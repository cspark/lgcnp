class Fcafterinterview < ApplicationRecord
  self.table_name = "fcafterinterview" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :after_interview_id if Rails.env.production?  || Rails.env.staging?

end
