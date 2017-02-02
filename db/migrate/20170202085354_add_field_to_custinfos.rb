class AddFieldToCustinfos < ActiveRecord::Migration[5.0]
  def change
    add_column :custinfos, :is_agree_privacy, :string
    add_column :custinfos, :is_agree_after, :string
    add_column :custinfos, :is_agree_marketing, :string
    add_column :custinfos, :is_agree_thirdparty_info, :string
  end
end
