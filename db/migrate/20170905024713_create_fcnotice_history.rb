class CreateFcnoticeHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :fcnotice_histories do |t|
      t.string :upload_date, null: false
      t.string :begin_date
      t.string :end_date
      t.string :file_name
      t.string :notice_comment

      t.timestamps
    end
  end
end
