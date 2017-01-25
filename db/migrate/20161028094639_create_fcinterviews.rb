class CreateFcinterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :fcinterviews do |t|
      t.string :custserial, null:false
      t.string :faceno
      t.string :measuredate
      t.integer :measureno
      t.string :uptdate
      t.string :interview_1
      t.string :interview_2
      t.string :interview_3
      t.string :interview_4
      t.string :interview_5
      t.string :interview_6
      t.string :interview_7
      t.string :interview_8
      t.timestamps
    end
  end
end
