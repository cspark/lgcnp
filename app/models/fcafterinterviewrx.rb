class Fcafterinterviewrx < ApplicationRecord
  self.table_name = "fcafterinterviewrx" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :after_interview_id if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      custserial: custserial,
      rx_tablet_interview_id: rx_tablet_interview_id,
      after_interview_id: after_interview_id,
      a1: a1,
      a1_1: a1_1,
      a2: a2,
      a3: a3,
      a4: a4,
      a5: a5,
      a3_1: a3_1,
      a5_1: a5_1,
      a6: a6,
      a6_1: a6_1,
      a7: a7,
      order: order,
      rx_tablet_interview_uptdate: rx_tablet_interview_uptdate,
      uptdate: uptdate
    }
  end
end
