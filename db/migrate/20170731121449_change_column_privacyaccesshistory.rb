class ChangeColumnPrivacyaccesshistory < ActiveRecord::Migration[5.0]
  def change
    change_column :privacyaccesshistories, :ip, :string
  end
end
