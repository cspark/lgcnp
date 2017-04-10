class AddFieldToFctabletinterviewSummary < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviewrx_summaries, :cnp_tablet_count, :integer
    add_column :fctabletinterviewrx_summaries, :cnpr_tablet_count, :integer
  end
end
