class TbSurveyAnswer < ApplicationRecord
  self.table_name = "tb_survey_answer" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :answer_serial if Rails.env.production? || Rails.env.staging?


end
