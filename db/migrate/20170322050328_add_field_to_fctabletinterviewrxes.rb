class AddFieldToFctabletinterviewrxes < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :bb_base_before, :string
    add_column :fctabletinterviewrxes, :bb_base_after, :string
  end
end
