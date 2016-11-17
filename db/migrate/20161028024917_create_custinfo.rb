class CreateCustinfo < ActiveRecord::Migration[5.0]
  def change
    create_table :custinfos do |t|
      t.string :SERIAL, null: false
      t.string :CUSTNAME
      t.string :SEX
      t.string :BIRTHYY
      t.string :BIRTHMM
      t.string :BIRTHDD
      t.string :AGE
      t.string :PHONE
      t.string :ADDRESS
      t.string :EMAIL
      t.string :LASTANALDATE
      t.string :MEASURENO
      t.string :UPTDATE

      t.timestamps null: false
    end
  end
end
