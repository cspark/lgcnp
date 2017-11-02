class Fcinterview < ApplicationRecord
  self.table_name = "fcinterview" if Rails.env.production? || Rails.env.staging?
  
  def to_api_hash
    {
      custserial: custserial,
      ch_cd: ch_cd,
      faceno: faceno,
      measuredate: measuredate,
      measureno: measureno,
      uptdate: uptdate,
      interview_1: interview_1,
      interview_2: interview_2,
      interview_3: interview_3,
      interview_4: interview_4,
      interview_5: interview_5,
      interview_6: interview_6,
      interview_7: interview_7,
      interview_8: interview_8,
      interview_9: interview_9,
      interview_10: interview_10,
      shop_cd: shop_cd
    }
  end
end
