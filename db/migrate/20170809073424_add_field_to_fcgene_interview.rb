class AddFieldToFcgeneInterview < ActiveRecord::Migration[5.0]
  def change
    add_column :fcgene_interviews, :q6, :string
  end
end
