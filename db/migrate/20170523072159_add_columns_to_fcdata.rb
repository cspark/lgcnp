class AddColumnsToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :uf_1, :integer
    add_column :fcdata, :uf_2, :integer
    add_column :fcdata, :uf_3, :integer
    add_column :fcdata, :uf_4, :integer
    add_column :fcdata, :uf_5, :integer
    add_column :fcdata, :uf_6, :integer
    add_column :fcdata, :uf_7, :integer
    add_column :fcdata, :uf_8, :integer
    add_column :fcdata, :uf_avr, :integer
  end
end
