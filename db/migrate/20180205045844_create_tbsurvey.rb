class CreateTbsurvey < ActiveRecord::Migration[5.0]
  def change
    create_table :tbsurveys do |t|
      t.integer :survey_serial
      t.string :survey_title
      t.datetime :survey_st_dt
      t.datetime :survey_ed_dt
      t.datetime :create_dt
      t.string :create_id
      t.datetime :update_dt
      t.string :update_id
      t.string :use_yn
      t.string :save_state
    end
  end
end
