class AddColumnCustinfo < ActiveRecord::Migration[5.0]
  def change
    add_column :custinfos, :is_agree_privacy_residence, :string
  end
end
