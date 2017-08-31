class AddFieldToFcshop < ActiveRecord::Migration[5.0]
  def change
    add_column :fcshops, :version_name, :string
  end
end
