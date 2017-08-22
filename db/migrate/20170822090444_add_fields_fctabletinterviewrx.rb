class AddFieldsFctabletinterviewrx < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrxes, :before_solution_1_new, :string
    add_column :fctabletinterviewrxes, :before_solution_2_new, :string
  end
end
