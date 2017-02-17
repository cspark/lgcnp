class GenerateTestModel < ApplicationRecord
  def self.generate_test_fctabletinterview
    f = Fctabletinterview.new

    c = Custinfo.new
    c.custserial = 1
    c.custname = "JJ"
    c.birthyy = "1988"
    c.birthmm = "05"
    c.ch_cd = "CNP"
    c.save
    f.custserial = Custinfo.first.custserial

    f.tablet_interview_id = Fctabletinterview.all.count
    f.ch_cd = "CNP"
    f.skin_type = "skin_type_jisung_senstive"
    f.before_solution_1 = "pore solution"
    f.after_solution_1 = "pore solution"
    f.before_solution_2 = "pore solution"
    f.after_solution_2 = "pore solution"
    f.before_serum = "skin control"
    f.after_serum = "skin control"
    f.before_ample_1 = "pore clinic ampoule"
    f.after_ample_1 = "pore clinic ampoule"
    f.before_ample_2 = "pore clinic ampoule"
    f.after_ample_2 = "pore clinic ampoule"

    f.before_made_cosmetic = "skin control EX"
    f.after_made_cosmetic = "skin control EX"
    f.fcdata_id = 1
    f.uptdate = "2017-02-19-15-20"
    f.is_quick_mode = "F"
    f.save
  end

  def self.generate_test_fcavgdata
    num = 58
    (1..num).each do |i|
       f = Fcavgdata.new
       f.n_index = i
       f.age = 0
       f.pore = 1.0
       f.wrinkle = 1.0
       f.spot_pl = 1.0
       f.spot_uv = 1.0
       f.elasticity = 1.0
       f.porphyrin_ratio = 1.0
       f.e_sebum_t = 1.0
       f.e_sebum_u = 1.0
       f.moisture = 1.0
       f.e_porphyrin_t = 1.0
       f.e_porphyrin_u = 1.0
       f.save
       i +=1;
    end

  end
end
