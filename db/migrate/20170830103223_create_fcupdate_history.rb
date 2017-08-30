class CreateFcupdateHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :fcupdate_history do |t|
      t.string :release_date,  null:false
      t.string :version_name,  null:false
      t.string :launcher_yn
      t.integer :upt_entry_num
      t.integer :upt_total_filesize
      t.string :upt_comment
    end
  end
end
