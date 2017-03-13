class CreateLoginHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :login_histories do |t|
      t.string :email, null: false
      t.string :ip
      t.string :created_at, null: false, :default => Time.now.to_s
      t.string :updated_at, null: false, :default => Time.now.to_s
    end
  end
end
