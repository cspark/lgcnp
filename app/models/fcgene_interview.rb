class FcgeneInterview < ApplicationRecord
  self.table_name = "fcgene_interview" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial,:gene_barcode,:measureno if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      custserial: custserial,
      gene_barcode: gene_barcode,
      ch_cd: ch_cd,
      measureno: measureno,
      shop_cd: shop_cd,
      q1_height: q1_height,
      q1_weight: q1_weight,
      q2: q2,
      q3: q3,
      q4: q4,
      q5: q5,
      q6: q6,
      q7: q7,
      q8: q8,
      q9: q9,
      q10: q10,
      q11: q11,
      q12: q12,
      q13: q13,
      q14: q14,
      uptdate: uptdate
    }
  end
end
