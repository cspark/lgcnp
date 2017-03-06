class AddColumnToFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviews, :ch_cd, :string
  end
end
