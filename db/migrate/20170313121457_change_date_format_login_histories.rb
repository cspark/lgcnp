class ChangeDateFormatLoginHistories < ActiveRecord::Migration[5.0]
  def change
    change_column :login_histories, :created_at, :datetime
    change_column :login_histories, :updated_at, :datetime
  end
end
