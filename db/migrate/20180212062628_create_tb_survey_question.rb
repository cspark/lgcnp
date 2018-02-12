class CreateTbSurveyQuestion < ActiveRecord::Migration[5.0]
  def change
    create_table :tb_survey_questions do |t|
      t.integer :group_serial
      t.integer :question_serial
      t.integer :question_order
      t.string :question_type
      t.integer :answer_count
      t.string :answers_type
      t.string :question_contents
      t.string :question_img_url
      t.string :use_yn
      t.string :save_state
      t.datetime :create_dt
      t.string :create_id
      t.datetime :update_dt
      t.string :update_id
      t.string :end_yn
    end
  end
end
