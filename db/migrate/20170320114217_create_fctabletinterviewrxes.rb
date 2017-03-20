class CreateFctabletinterviewrxes < ActiveRecord::Migration[5.0]
  def change
    create_table :fctabletinterviewrxes do |t|
	  t.string :custserial, null:false
      t.string :ch_cd, null:false
      t.integer :tablet_interview_id, null:false
      t.integer :a_1
      t.integer :a_2
      t.integer :a_3
      t.integer :b_1
      t.integer :b_2
      t.integer :b_3
      t.integer :b_4
      t.integer :b_5
      t.integer :b_6
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
      t.integer :d_11
      t.string :skin_type
      t.string :before_solution_1
      t.string :after_solution_1
      t.string :before_solution_2
      t.string :after_solution_2
      t.string :before_ample_1
      t.string :after_ample_1
      t.string :before_ample_2
      t.string :after_ample_2
      t.string :uptdate
      t.string :is_agree_cant_refund
      t.string :is_agree_after
      t.string :mmode
      t.string :brefore_production
      t.string :after_production
      t.string :bb_base
      t.string :before_cushion_1
      t.string :after_cushion_1
      t.string :before_cushion_2
      t.string :after_cushion_2
      t.integer :fcdata_id
      t.integer :turnover_value
      t.integer :corneous_value
      t.float :stress_value

      t.timestamps
    end
  end
end
