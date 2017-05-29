class ChangeColumnToFctabletinterviewrxes < ActiveRecord::Migration[5.0]
  def change
    rename_column :fctabletinterviewrxes, :recommand_bb, :recommand_program1
    rename_column :fctabletinterviewrxes, :recommand_sun, :recommand_program2
  end
end
