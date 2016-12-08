class CreateFcavgdata < ActiveRecord::Migration[5.0]
  def change
    create_table :fcavgdata do |t|

      t.timestamps
    end
  end
end
