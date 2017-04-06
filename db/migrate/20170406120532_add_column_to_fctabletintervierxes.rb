class AddColumnToFctabletintervierxes < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :purchase_1, :text
    add_column :fctabletinterviewrxes, :purchase_2, :text
    add_column :fctabletinterviewrxes, :purchase_3, :text
  end
end
