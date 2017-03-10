class AddFieldToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :ch_cd, :string
    add_column :admin_users, :shop_cd, :string
    add_column :admin_users, :role, :string
  end
end
