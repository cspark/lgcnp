class AddFieldToFcpos < ActiveRecord::Migration[5.0]
  def change
    add_column :fcpos, :shop_cd, :string
  end
end
