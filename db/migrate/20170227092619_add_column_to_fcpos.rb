class AddColumnToFcpos < ActiveRecord::Migration[5.0]
  def change
    add_column :fcpos, :ch_cd, :string
  end
end
