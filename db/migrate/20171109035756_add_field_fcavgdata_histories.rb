class AddFieldFcavgdataHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :fcavgdata_histories, :his_start_date, :string
    add_column :fcavgdata_histories, :n_index, :integer
    add_column :fcavgdata_histories, :age, :string
    add_column :fcavgdata_histories, :pore, :integer
    add_column :fcavgdata_histories, :wrinkle, :integer
    add_column :fcavgdata_histories, :spot_pl, :integer
    add_column :fcavgdata_histories, :spot_uv, :integer
    add_column :fcavgdata_histories, :elasticity, :integer
    add_column :fcavgdata_histories, :porphyrin_ratio, :integer
    add_column :fcavgdata_histories, :e_sebum_t, :float
    add_column :fcavgdata_histories, :e_sebum_u, :float
    add_column :fcavgdata_histories, :moisture, :integer
    add_column :fcavgdata_histories, :e_porphyrin_t, :float
    add_column :fcavgdata_histories, :e_porphyrin_u, :float
    add_column :fcavgdata_histories, :his_end_date, :string
  end
end
