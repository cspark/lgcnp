class TbSurveyGroup < ApplicationRecord
  self.table_name = "tb_survey_group" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :survey_serial if Rails.env.production? || Rails.env.staging?

end
