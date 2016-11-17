class Fcinterview < ApplicationRecord
  def to_api_hash
    {
      custserial: self.CUSTSERIAL,
      faceno: self.FACENO,
      measuredate: self.MEASUREDATE,
      measureno: self.MEASURENO,
      uptdate: self.UPTDATE,
      interview1: self.INTERVIEW_1,
      interview2: self.INTERVIEW_2,
      interview3: self.INTERVIEW_3,
      interview4: self.INTERVIEW_4,
      interview5: self.INTERVIEW_5,
      interview6: self.INTERVIEW_6,
      interview7: self.INTERVIEW_7,
      interview8: self.INTERVIEW_8
    }
  end
end
