class ChangeFieldToAdminFcdata < ActiveRecord::Migration[5.0]
  def change
    change_column :fcdata, :uf_l0, :integer
    change_column :fcdata, :uf_l_total, :integer
  end
end
