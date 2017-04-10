class FctabletinterviewrxSummary < ApplicationRecord
  self.table_name = "fctabletinterviewrxsummary" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      interview_mode_count: interview_mode_count,
      cnp_tablet_count: cnp_tablet_count,
      cnpr_tablet_count: cnpr_tablet_count
    }
  end
end
