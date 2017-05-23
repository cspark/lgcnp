class AddColumnToCustinfo < ActiveRecord::Migration[5.0]
  def change
    add_column :custinfos, :gene_barcode, :string
  end
end
