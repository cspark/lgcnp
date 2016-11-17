class CreateFcinterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :fcinterviews do |t|
      t.string :CUSTSERIAL, null:false
      t.string :FACENO
      t.string :MEASUREDATE
      t.integer :MEASURENO
      t.string :UPTDATE
      t.string :INTERVIEW_1
      t.string :INTERVIEW_2
      t.string :INTERVIEW_3
      t.string :INTERVIEW_4
      t.string :INTERVIEW_5
      t.string :INTERVIEW_6
      t.string :INTERVIEW_7
      t.string :INTERVIEW_8
      t.timestamps
    end
  end
end
