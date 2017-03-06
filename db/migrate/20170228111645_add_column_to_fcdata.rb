class AddColumnToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :m_skintype, :integer
  end
end
