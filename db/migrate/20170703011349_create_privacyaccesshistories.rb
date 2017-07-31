class CreatePrivacyaccesshistories < ActiveRecord::Migration[5.0]
  def change
    create_table :privacyaccesshistories do |t|
      t.string :adminuser_id
      t.string :email
      t.integer :ip
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
