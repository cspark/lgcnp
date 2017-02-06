class CreateTableFcAfterInterview < ActiveRecord::Migration[5.0]
  def change
    create_table :table_fc_after_interviews do |t|
      t.string :custserial,  null:false
      t.integer :tablet_interview_id
      t.integer :after_interview_id
      t.integer :a1
      t.integer :a2
      t.integer :a3
      t.integer :a4
      t.text :a5
    end
  end
end
