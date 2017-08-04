class AddColumnToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :fcshops, :tel_no, :string
    add_column :fcshops, :address, :string
  end
end
