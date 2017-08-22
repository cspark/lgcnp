class AddFieldsFctabletinterview < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviews, :before_solution_1_new, :string
    add_column :fctabletinterviews, :before_solution_2_new, :string
  end
end
