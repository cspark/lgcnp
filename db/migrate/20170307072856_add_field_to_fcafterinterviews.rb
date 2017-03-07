class AddFieldToFcafterinterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :fcafterinterviews, :order, :integer
    add_column :fcafterinterviews, :a1_1, :text
    add_column :fcafterinterviews, :tablet_interview_update, :string
    add_column :fcafterinterviews, :uptdate, :string
  end
end
