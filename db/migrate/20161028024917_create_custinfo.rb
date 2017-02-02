class CreateCustinfo < ActiveRecord::Migration[5.0]
  def change
    create_table :custinfos do |t|
      t.string :custserial, null: false
      t.string :custname
      t.string :sex
      t.string :birthyy
      t.string :birthmm
      t.string :birthdd
      t.string :age
      t.string :phone
      t.string :address
      t.string :email
      t.string :lastanaldate
      t.string :measureno
      t.string :uptdate

      t.timestamps null: false
    end
  end
end
