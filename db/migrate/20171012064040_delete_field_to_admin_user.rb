class DeleteFieldToAdminUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :admin_users, :password_salt
  end
end
