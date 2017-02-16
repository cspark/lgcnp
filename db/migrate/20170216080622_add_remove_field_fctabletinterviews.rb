class AddRemoveFieldFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviews, :before_made_cosmetic, :string
    add_column :fctabletinterviews, :after_made_cosmetic, :string
    remove_column :fctabletinterviews, :before_ready_made_cosmetic, :string
    remove_column :fctabletinterviews, :after_ready_made_cosmetic, :string
  end
end
