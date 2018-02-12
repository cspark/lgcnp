class CreateTbSurveyResult < ActiveRecord::Migration[5.0]
  def change
    create_table :tb_survey_results do |t|
      t.integer :group_serial
      t.integer :result_serial
      t.string :result_type
      t.integer :score_start
      t.integer :score_end
      t.string :result_img_url
      t.string :result_title
      t.string :result_contents
      t.datetime :create_dt
      t.string :create_id
      t.datetime :update_dt
      t.string :update_id
      t.integer :result_order
      t.text :result_html
    end
  end
end
