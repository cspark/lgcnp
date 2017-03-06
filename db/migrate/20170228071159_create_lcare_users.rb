class CreateLcareUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :lcare_users do |t|
      t.string :n_cust_id, null:false
      t.string :cust_hnm
      t.string :sex_cd
      t.integer :birth_year
      t.string :birth_mmdd
      t.string :cell_phnno
      t.string :u_cust_yn
      t.timestamps
    end
  end
end
