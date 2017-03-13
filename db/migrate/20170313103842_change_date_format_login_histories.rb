class ChangeDateFormatLoginHistories < ActiveRecord::Migration[5.0]
  change_column :login_histories, :created_at, :datetime
  change_column :login_histories, :updated_at, :datetime
end
