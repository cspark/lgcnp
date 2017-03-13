class LoginHistory < ApplicationRecord
  self.table_name = "loginhistory" if Rails.env.production? || Rails.env.staging?
  # self.set_datetime_columns :created_at, :updated_at if Rails.env.production? || Rails.env.staging?

end
