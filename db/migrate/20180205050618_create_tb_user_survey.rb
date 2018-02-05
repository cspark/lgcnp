class CreateTbUserSurvey < ActiveRecord::Migration[5.0]
  def change
    create_table :tb_user_surveys do |t|
      t.integer :custserial
      t.integer :question_serial
      t.integer :answer_serial
      t.string :answer_reply
      t.datetime :create_dt
      t.datetime :update_dt
    end
  end
end
