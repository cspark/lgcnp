class AddColToAdminUser < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :last_change_password_at, :string
  end
end
