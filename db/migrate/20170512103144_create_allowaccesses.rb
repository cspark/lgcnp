class CreateAllowaccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :allowaccesses do |t|
      t.string :low_ip
      t.string :high_ip
      t.timestamps
    end
  end
end
