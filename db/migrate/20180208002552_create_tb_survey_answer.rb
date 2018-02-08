class CreateTbSurveyAnswer < ActiveRecord::Migration[5.0]
  def change
    create_table :tb_survey_answers do |t|
      t.integer :question_serial
      t.integer :answer_serial
      t.string :answer_type
      t.integer :answer_point
      t.string :answer_contents
      t.string :answer_img_url
      t.datetime :create_dt
      t.string :create_id
      t.datetime :update_dt
      t.string :update_id
      t.integer :answer_order

    end
  end
end
