class Fctabletinterview < ApplicationRecord
  def to_api_hash
    {
      custserial: self.CUSTSERIAL,
      a1: self.A_1,
      a2: self.A_2,
      a3: self.A_3,
      b1: self.B_1,
      b2: self.B_2,
      b3: self.B_3,
      b4: self.B_4,
      c1: self.C_1,
      d1: self.D_1,
      d2: self.D_2,
      d3: self.D_3,
      d4: self.D_4,
      d5: self.D_5,
      d6: self.D_6,
      d7: self.D_7,
      d8: self.D_8,
      d9: self.D_9,
      d10: self.D_10,
      skinType: self.SKIN_TYPE,
      solutionBeforeSolution1: self.SOLUTION_BEFORE_SOLUTION_1,
      solutionAfterSolution1: self.SOLUTION_AFTER_SOLUTION_1,
      solutionAfterSolution2: self.SOLUTION_BEFORE_SOLUTION_2,
      solutionBeforeSolution2: self.SOLUTION_AFTER_SOLUTION_2,
      solutionBeforeSerum: self.SOLUTION_BEFORE_SERUM,
      solutionAfterSerum: self.SOLUTION_AFTER_SERUM,
      solutionBeforeAmple1: self.SOLUTION_BEFORE_AMPLE_1,
      solutionAfterAmpole1: self.SOLUTION_AFTER_AMPLE_1,
      solutionBeforeAmple2: self.SOLUTION_BEFORE_AMPLE_2,
      solutionAfterAmpole2: self.SOLUTION_AFTER_AMPLE_2,
      solutionBeforeReadyMadeCosmetic: self.SOLUTION_BEFORE_READY_MADE_COSMETIC,
      solutionAfterReadyMadeCosmetic: self.SOLUTION_AFTER_READY_MADE_COSMETIC
    }
end

def input_random_value
  self.A_1=SecureRandom.random_number(5)
  self.A_2=SecureRandom.random_number(5)
  self.A_3=SecureRandom.random_number(5)
  self.B_1=SecureRandom.random_number(5)
  self.B_2=SecureRandom.random_number(5)
  self.B_3=SecureRandom.random_number(5)
  self.B_4=SecureRandom.random_number(5)
  self.C_1=SecureRandom.random_number(5)
  self.D_1=SecureRandom.random_number(5)
  self.D_2=SecureRandom.random_number(5)
  self.D_3=SecureRandom.random_number(5)
  self.D_4=SecureRandom.random_number(5)
  self.D_5=SecureRandom.random_number(5)
  self.D_6=SecureRandom.random_number(5)
  self.D_7=SecureRandom.random_number(5)
  self.D_8=SecureRandom.random_number(5)
  self.D_9=SecureRandom.random_number(5)
  self.D_10=SecureRandom.random_number(5)
  self.SKIN_TYPE="type"
  self.SOLUTION_BEFORE_SOLUTION_1="bsol1"
  self.SOLUTION_AFTER_SOLUTION_1="asol2"
  self.SOLUTION_BEFORE_SOLUTION_2="bsol2"
  self.SOLUTION_AFTER_SOLUTION_2="asol2"
  self.SOLUTION_BEFORE_SERUM="bser"
  self.SOLUTION_AFTER_SERUM="aser"
  self.SOLUTION_BEFORE_AMPLE_1="bam1"
  self.SOLUTION_AFTER_AMPLE_1="aam1"
  self.SOLUTION_BEFORE_AMPLE_2="bam2"
  self.SOLUTION_AFTER_AMPLE_2="aam2"
  self.SOLUTION_BEFORE_READY_MADE_COSMETIC="brm"
  self.SOLUTION_AFTER_READY_MADE_COSMETIC="arm"
end
end
