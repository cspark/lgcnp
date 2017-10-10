class AddFieldToAdminFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcupdate_history, :ch_cd, :string
  end
end
