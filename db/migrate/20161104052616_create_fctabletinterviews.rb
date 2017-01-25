class CreateFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :fctabletinterviews do |t|
      t.string :custserial, null:false
      t.integer :a_1
      t.integer :a_2
      t.integer :a_3
      t.integer :b_1
      t.integer :b_2
      t.integer :b_3
      t.integer :b_4
      t.integer :c_1
      t.integer :d_1
      t.integer :d_2
      t.integer :d_3
      t.integer :d_4
      t.integer :d_5
      t.integer :d_6
      t.integer :d_7
      t.integer :d_8
      t.integer :d_9
      t.integer :d_10
      t.string :skin_type
      t.string :solution_before_solution_1
      t.string :solution_after_solution_1
      t.string :solution_before_solution_2
      t.string :solution_after_solution_2
      t.string :solution_before_serum
      t.string :solution_after_serum
      t.string :solution_before_ample_1
      t.string :solution_after_ample_1
      t.string :solution_before_ample_2
      t.string :solution_after_ample_2
      t.string :solution_before_ready_made_cosmetic
      t.string :solution_after_ready_made_cosmetic

      t.timestamps
    end
  end
end
