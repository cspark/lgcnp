class AddFieldsToFctabletinterivewrx < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :before_overlap, :string
    add_column :fctabletinterviewrxes, :after_overlap, :string
    add_column :fctabletinterviewrxes, :recommand_bb, :string
    add_column :fctabletinterviewrxes, :recommand_sun, :string
  end
end
