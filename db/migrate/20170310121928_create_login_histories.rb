class CreateLoginHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :login_histories do |t|
      t.string :email, null: false
      t.string :ip
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
