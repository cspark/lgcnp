class CreateLoginHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :login_histories do |t|
      t.string :email, null: false
      t.string :ip

      t.timestamps
    end
  end
end
