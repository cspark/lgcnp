class LoginHistory < ApplicationRecord
  self.table_name = "loginhistory" if Rails.env.production? || Rails.env.staging?

end
