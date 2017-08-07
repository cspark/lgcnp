class AddFieldPrivateaccesshistory < ActiveRecord::Migration[5.0]
  def change
    add_column :privacyaccesshistories, :category, :string
  end
end
