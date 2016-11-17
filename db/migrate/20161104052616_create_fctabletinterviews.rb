class CreateFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :fctabletinterviews do |t|
      t.string :CUSTSERIAL, null:false
      t.integer :A_1
      t.integer :A_2
      t.integer :A_3
      t.integer :B_1
      t.integer :B_2
      t.integer :B_3
      t.integer :B_4
      t.integer :C_1
      t.integer :D_1
      t.integer :D_2
      t.integer :D_3
      t.integer :D_4
      t.integer :D_5
      t.integer :D_6
      t.integer :D_7
      t.integer :D_8
      t.integer :D_9
      t.integer :D_10
      t.string :SKIN_TYPE
      t.string :SOLUTION_BEFORE_SOLUTION_1
      t.string :SOLUTION_AFTER_SOLUTION_1
      t.string :SOLUTION_BEFORE_SOLUTION_2
      t.string :SOLUTION_AFTER_SOLUTION_2
      t.string :SOLUTION_BEFORE_SERUM
      t.string :SOLUTION_AFTER_SERUM
      t.string :SOLUTION_BEFORE_AMPLE_1
      t.string :SOLUTION_AFTER_AMPLE_1
      t.string :SOLUTION_BEFORE_AMPLE_2
      t.string :SOLUTION_AFTER_AMPLE_2
      t.string :SOLUTION_BEFORE_READY_MADE_COSMETIC
      t.string :SOLUTION_AFTER_READY_MADE_COSMETIC

      t.timestamps
    end
  end
end
