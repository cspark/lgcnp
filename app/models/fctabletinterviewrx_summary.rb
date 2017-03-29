class FctabletinterviewrxSummary < ApplicationRecord
  self.table_name = "fctabletinterviewrxsummary" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      interview_mode_count: interview_mode_count,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
