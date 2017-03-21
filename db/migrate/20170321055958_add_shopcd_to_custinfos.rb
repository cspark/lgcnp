class AddShopcdToCustinfos < ActiveRecord::Migration[5.0]
  def change
    add_column :custinfos, :shop_cd, :string
  end
end
