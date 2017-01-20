class Fctabletinterview < ApplicationRecord
  self.table_name = "fctabletinterview"
  self.primary_key = :tablet_interview_id

  def self.get_answer(value: value)
    if value == 5
      return 3
    elsif value == 6
      return 4
    end
    return value
  end

  def self.get_sensitive_value(value: value)
    if value == 5
      return 5
    else
      return 0
    end
  end

  def self.calculate()
    Fctabletinterview.all.each do |fctabletinterview|
      if fctabletinterview.skin_type.nil? || fctabletinterview.skin_type == "null"
        calculate_value = 0
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_1)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_2)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_3)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_4)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_5)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_6)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_7)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_8)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_9)
        calculate_value = calculate_value + Fctabletinterview.get_answer(value: fctabletinterview.d_10)

        sensitive_value = 0
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_1)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_2)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_3)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_4)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_5)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_6)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_7)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_8)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_9)
        sensitive_value = sensitive_value + Fctabletinterview.get_sensitive_value(value: fctabletinterview.d_10)

        if calculate_value >= 17
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_senstive"
          elsif (senstiveSum >= 5 && senstiveSum <= 12)
            fctabletinterview.skin_type = "skin_type_jisung"
          end
        end

        if calculate_value >= 13 && calculate_value <= 16
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_boghab_senstive"
          elsif (senstiveSum >= 5 && senstiveSum <= 12)
            fctabletinterview.skin_type = "skin_type_jisung_boghab"
          end
        end

        if calculate_value >= 10 && calculate_value <= 12
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gun_boggab_senstive"
          elsif (senstiveSum >= 5 && senstiveSum <= 12)
            fctabletinterview.skin_type = "skin_type_gun_boggab"
          end
        end

        if calculate_value >= 5 && calculate_value <= 9
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gunsung_senstive"
          elsif (senstiveSum >= 5 && senstiveSum <= 12)
            fctabletinterview.skin_type = "skin_type_gunsung"
          end
        end

        if (fctabletinterview.d4 == 5 && fctabletinterview.d5 == 5) || (fctabletinterview.a2 == 4 && ((fctabletinterview.d4 == 2 && fctabletinterview.d5 == 3) || (fctabletinterview.d4 == 2 && fctabletinterview.d5 == 5) || (fctabletinterview.d4 == 5 && fctabletinterview.d5 == 2)))
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jungsung_senstive"
          elsif (senstiveSum >= 5 && senstiveSum <= 12)
            fctabletinterview.skin_type = "skin_type_jungsung"
          end
        end
      end
    end
  end

  def to_api_hash
    {
      custserial: custserial,
      tablet_interview_id: tablet_interview_id,
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
      after_made_cosmetic: after_made_cosmetic,
      uptdate: uptdate,
      fcdata_id: fcdata_id,
      is_quick_mode: is_quick_mode,
      base_lot: base_lot,
      ampoule_1_lot: ampoule_1_lot,
      ampoule_2_lot: ampoule_2_lot,
      mixer_name: mixer_name,
      is_make_up: is_make_up,
      memo: memo,
      is_agree_cant_refund: is_agree_cant_refund
    }
  end
end
