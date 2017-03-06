class AddColumnToFcinterview < ActiveRecord::Migration[5.0]
  def change
    add_column :fcinterviews, :ch_cd, :string
    add_column :fcinterviews, :interview_9, :string
    add_column :fcinterviews, :interview_10, :string
    add_column :fcinterviews, :shop_cd, :string
  end
end
