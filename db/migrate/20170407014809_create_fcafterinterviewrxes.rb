class CreateFcafterinterviewrxes < ActiveRecord::Migration[5.0]
  def change
    create_table :fcafterinterviewrxes do |t|
      t.string :custserial,  null:false
      t.integer :rx_tablet_interview_id
      t.integer :after_interview_id
      t.integer :a1
      t.text :a1_1
      t.integer :a2
      t.integer :a3
      t.integer :a4
      t.text :a5
      t.integer :order
      t.string :rx_tablet_interview_update
      t.string :uptdate
      t.timestamps
    end
  end
end
