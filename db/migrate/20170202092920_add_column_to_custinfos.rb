class AddColumnToCustinfos < ActiveRecord::Migration[5.0]
  def change
    add_column :custinfos, :ch_cd, :string
  end
end
