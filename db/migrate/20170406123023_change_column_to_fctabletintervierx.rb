class ChangeColumnToFctabletintervierx < ActiveRecord::Migration[5.0]
  def change
    rename_column :fctabletinterviewrxes, :purchase_1, :purchase1
    rename_column :fctabletinterviewrxes, :purchase_2, :purchase2
    rename_column :fctabletinterviewrxes, :purchase_3, :purchase3
  end
end
