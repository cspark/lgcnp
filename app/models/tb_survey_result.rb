class TbSurveyResult < ApplicationRecord
  self.table_name = "tb_survey_result" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :result_serial if Rails.env.production? || Rails.env.staging?

end
