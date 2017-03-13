class ChangeDateFormatLoginHistories < ActiveRecord::Migration[5.0]
  change_table :login_histories do |t|
    t.change :created_at, :datetime
    t.change :updated_at, :datetime
  end
end
