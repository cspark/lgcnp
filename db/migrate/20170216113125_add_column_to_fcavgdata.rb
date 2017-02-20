class AddColumnToFcavgdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcavgdata, :n_index, :integer
    add_column :fcavgdata, :age, :string
    add_column :fcavgdata, :pore, :integer
    add_column :fcavgdata, :wrinkle, :integer
    add_column :fcavgdata, :spot_pl, :integer
    add_column :fcavgdata, :spot_uv, :integer
    add_column :fcavgdata, :elasticity, :integer
    add_column :fcavgdata, :porphyrin_ratio, :integer
    add_column :fcavgdata, :e_sebum_t, :float
    add_column :fcavgdata, :e_sebum_u, :float
    add_column :fcavgdata, :moisture, :integer
    add_column :fcavgdata, :e_porphyrin_t, :float
    add_column :fcavgdata, :e_porphyrin_u, :float
  end
end
