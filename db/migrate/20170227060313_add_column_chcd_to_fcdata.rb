class AddColumnChcdToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :ch_cd, :string
    add_column :fcdata, :e_sebum_t, :float
    add_column :fcdata, :e_sebum_u, :float
    add_column :fcdata, :e_porphyrin_t, :float
    add_column :fcdata, :e_porphyrin_u, :float
    add_column :fcdata, :janus_status, :integer
    add_column :fcdata, :shop_cd, :string
    add_column :fcdata, :worry_skin_1, :string
    add_column :fcdata, :worry_skin_2, :string
  end
end
