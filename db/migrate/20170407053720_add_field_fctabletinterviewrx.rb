class AddFieldFctabletinterviewrx < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :base_lot, :string
    add_column :fctabletinterviewrxes, :ampoule_1_lot, :string
    add_column :fctabletinterviewrxes, :ampoule_2_lot, :string
    add_column :fctabletinterviewrxes, :mixer_name, :string
    add_column :fctabletinterviewrxes, :memo, :text
  end
end
