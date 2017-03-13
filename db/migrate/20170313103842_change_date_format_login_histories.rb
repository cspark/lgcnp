class ChangeDateFormatLoginHistories < ActiveRecord::Migration[5.0]
  def up
    change_column :login_histories, :created_at, :datetime, :default => Time.now
    change_column :login_histories, :updated_at, :datetime, :default => Time.now
  end

  def down
    change_column :login_histories, :created_at, :date
    change_column :login_histories, :updated_at, :date
  end
end
