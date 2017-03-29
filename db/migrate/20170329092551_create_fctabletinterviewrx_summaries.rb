class CreateFctabletinterviewrxSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :fctabletinterviewrx_summaries do |t|
      t.integer :interview_mode_count
      t.timestamps
    end
  end
end
