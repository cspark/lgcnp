class CreateFcmodecnts < ActiveRecord::Migration[5.0]
  def change
    create_table :fcmodecnts do |t|
      t.string :modecnt_serial
      t.string :shop_cd
      t.string :ch_cd
      t.string :analdate
      t.string :mode_name
      t.timestamps
    end
  end
end
