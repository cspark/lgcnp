class AddColumnToFcgeneinterview < ActiveRecord::Migration[5.0]
  def change
    add_column :fcgene_interviews, :q15_nation, :string
    add_column :fcgene_interviews, :q15_birth_nation, :string
  end
end
