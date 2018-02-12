class CreateTbSurveyGroup < ActiveRecord::Migration[5.0]
  def change
    create_table :tb_survey_groups do |t|
      t.integer :survey_serial
      t.integer :group_serial
      t.string :group_title
      t.string :group_contents
      t.integer :group_order
      t.string :result_yn
      t.string :reward_yn
      t.string :group_image_url
      t.string :use_yn
      t.datetime :create_dt
      t.string :create_id
      t.datetime :update_dt
      t.string :update_id
      t.string :reward_title
      t.string :reward_contents
      t.string :group_summary
      t.string :group_source
      t.string :target_sex
    end
  end
end
