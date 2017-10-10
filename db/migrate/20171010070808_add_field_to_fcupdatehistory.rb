class AddFieldToFcupdatehistory < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :uf_l0, :string
    add_column :fcdata, :uf_l_total, :string
  end
end
