class AddColumnToFcavgdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcavgdata, :n_index, :integer
    add_column :fcavgdata, :age, :string
    add_column :fcavgdata, :pore, :float
    add_column :fcavgdata, :wrinkle, :float
    add_column :fcavgdata, :spot_pl, :float
    add_column :fcavgdata, :spot_uv, :float
    add_column :fcavgdata, :elasticity, :float
    add_column :fcavgdata, :porphyrin_ratio, :float
    add_column :fcavgdata, :e_sebum_t, :float
    add_column :fcavgdata, :e_sebum_u, :float
    add_column :fcavgdata, :moisture, :float
    add_column :fcavgdata, :e_porphyrin_t, :integer
    add_column :fcavgdata, :e_porphyrin_u, :integer
  end
end
