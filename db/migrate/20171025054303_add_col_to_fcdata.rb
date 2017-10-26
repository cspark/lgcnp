class AddColToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :flag, :string
  end
end
