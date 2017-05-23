class CreateFcgeneInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :fcgene_interviews do |t|
      t.string :custserial
      t.string :gene_barcode
      t.string :ch_cd
      t.integer :measureno
      t.string :shop_cd
      t.string :q1_height
      t.string :q1_weight
      t.string :q2
      t.string :q3
      t.string :q4
      t.string :q5
      t.string :q7
      t.string :q8
      t.string :q9
      t.string :q10
      t.string :q11
      t.string :q12
      t.string :q13
      t.string :q14
      t.string :uptdate

      t.timestamps
    end
  end
end
