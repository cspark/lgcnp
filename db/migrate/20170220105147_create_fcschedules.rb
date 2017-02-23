class CreateFcschedules < ActiveRecord::Migration[5.0]
  def change
    create_table :fcschedules do |t|
      t.string :ch_cd, null:false
      t.string :shop_cd, null:false
      t.string :reserve_yyyy, null:false
      t.string :reserve_mmdd, null:false
      t.string :reserve_hhmm, null:false
      t.string :custname
      t.string :phone
      t.string :reserve_yn
      t.string :memo
      t.string :uptdate
      t.string :purchase_yn

      t.timestamps
    end
  end
end
