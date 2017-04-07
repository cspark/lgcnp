class AddFieldFcafterinterviewrx < ActiveRecord::Migration[5.0]
  def change
    add_column :fcafterinterviewrxes, :a3_1, :text
    add_column :fcafterinterviewrxes, :a5_1, :text
    add_column :fcafterinterviewrxes, :a6, :integer
    add_column :fcafterinterviewrxes, :a7, :text
  end
end
