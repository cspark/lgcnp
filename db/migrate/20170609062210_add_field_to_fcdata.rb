class AddFieldToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :age, :string
  end
end
