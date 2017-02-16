class AddFieldToFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
      add_column :fctabletinterviews, :uptdate, :string
  end
end
