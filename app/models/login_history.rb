class LoginHistory < ApplicationRecord
  self.table_name = "loginhistory" if Rails.env.production? || Rails.env.staging?
  # set_datetime_columns :created_at, :updated_at
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

end
