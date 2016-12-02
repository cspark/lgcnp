class Fctabletinterview < ApplicationRecord
  self.table_name = "fctabletinterview"
  self.primary_key = :tablet_interview_id

  def to_api_hash
    {
      custserial: custserial,
      interview_id: tablet_interview_id,
      a_1: a_1,
      a_2: a_2,
      a_3: a_3,
      b_1: b_1,
      b_2: b_2,
      b_3: b_3,
      b_4: b_4,
      c_1: c_1,
      d_1: d_1,
      d_2: d_2,
      d_3: d_3,
      d_4: d_4,
      d_5: d_5,
      d_6: d_6,
      d_7: d_7,
      d_8: d_8,
      d_9: d_9,
      d_10: d_10,
      skin_type: skin_type,
      before_solution_1: before_solution_1,
      after_solution_1: after_solution_1,
      before_solution_2: before_solution_2,
      after_solution_2: after_solution_2,
      before_serum: before_serum,
      after_serum: after_serum,
      before_ample_1: before_ample_1,
      after_ample_1: after_ample_1,
      before_ample_2: before_ample_2,
      after_ample_2: after_ample_2,
      before_made_cosmetic: before_made_cosmetic,
      after_made_cosmetic: after_made_cosmetic
    }
  end
end
