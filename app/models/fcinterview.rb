class Fcinterview < ApplicationRecord
  self.table_name = "fcinterview" if Rails.env.production? 

  def to_api_hash
    {
      custserial: custserial,
      faceno: faceno,
      measuredate: measuredate,
      measureno: measureno,
      uptdate: uptdate,
      interview1: interview1,
      interview2: interview2,
      interview3: interview3,
      interview4: interview4,
      interview5: interview5,
      interview6: interview6,
      interview7: interview7,
      interview8: interview8
    }
  end
end
