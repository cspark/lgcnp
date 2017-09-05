class CreateFclogAdmin < ActiveRecord::Migration[5.0]
  def change
    create_table :fclog_admins do |t|
      t.string :admin_id, null: false
      t.string :ip
      t.string :log_date
      t.string :work_name
      t.string :work_comment

      t.timestamps
    end
  end
end
