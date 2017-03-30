class AddColumnToFctabletinterviewrx < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :recommand_program_step_1, :text
    add_column :fctabletinterviewrxes, :recommand_program_step_2, :text
    add_column :fctabletinterviewrxes, :recommand_program_step_3, :text
  end
end
