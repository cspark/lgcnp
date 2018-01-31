class AddAccessIpToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :access_ip, :string
  end
end
