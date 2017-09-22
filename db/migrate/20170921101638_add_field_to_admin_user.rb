class AddFieldToAdminUser < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :password_salt, :string
  end
end
