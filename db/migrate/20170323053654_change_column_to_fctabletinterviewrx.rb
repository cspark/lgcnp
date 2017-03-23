class ChangeColumnToFctabletinterviewrx < ActiveRecord::Migration[5.0]
  def change
    rename_column :fctabletinterviewrxes, :brefore_production, :before_production
  end
end
