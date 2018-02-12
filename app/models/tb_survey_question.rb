class TbSurveyQuestion < ApplicationRecord
  self.table_name = "tb_survey_question" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :question_serial if Rails.env.production? || Rails.env.staging?

end
