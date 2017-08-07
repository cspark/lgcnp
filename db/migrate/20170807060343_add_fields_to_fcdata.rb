class AddFieldsToFcdata < ActiveRecord::Migration[5.0]
  def change
    add_column :fcdata, :el_cnt_7, :integer
    add_column :fcdata, :el_cnt_8, :integer
    add_column :fcdata, :worry_skin_new_1, :integer
    add_column :fcdata, :worry_skin_new_2, :integer
  end
end
