class TbUserSurvey < ApplicationRecord
  self.table_name = "tb_user_survey" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial if Rails.env.production? || Rails.env.staging?

end
