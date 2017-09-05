class CreateFccurationHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :fccuration_histories do |t|
      t.string :upload_date, null: false
      t.string :version_name
      t.string :cura_entry_filename
      t.string :cura_comment

      t.timestamps
    end
  end
end
