class CreateFcadminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :fcadmin_users do |t|
      t.string :admin_id, null:false
      t.string :encrypted_pw, null:false
      t.string :pw_uptdate
      t.string :create_date
      t.string :last_login_date

      t.timestamps
    end
  end
end
