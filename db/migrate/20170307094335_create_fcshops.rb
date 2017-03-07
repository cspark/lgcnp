class CreateFcshops < ActiveRecord::Migration[5.0]
  def change
    create_table :fcshops do |t|
      t.string :shop_cd,  null:false
      t.string :shop_name,  null:false
      t.string :ch_cd
      t.timestamps
    end
  end
end
