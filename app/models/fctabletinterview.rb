class Fctabletinterview < ApplicationRecord
  self.table_name = "fctabletinterview"

  def to_api_hash
    {
      custserial: custserial,
      a1: a1,
      a2: a2,
      a3: a3,
      b1: b1,
      b2: b2,
      b3: b3,
      b4: b4,
      c1: c1,
      d1: d1,
      d2: d2,
      d3: d3,
      d4: d4,
      d5: d5,
      d6: d6,
      d7: d7,
      d8: d8,
      d9: d9,
      d10: d10,
      skinType: skinType,
      solutionBeforeSolution1: solutionBeforeSolution1,
      solutionAfterSolution1: solutionAfterSolution1,
      solutionAfterSolution2: solutionAfterSolution2,
      solutionBeforeSolution2: solutionBeforeSolution2,
      solutionBeforeSerum: solutionBeforeSerum,
      solutionAfterSerum: solutionAfterSerum,
      solutionBeforeAmple1: solutionBeforeAmple1,
      solutionAfterAmpole1: solutionAfterAmpole1,
      solutionBeforeAmple2: solutionBeforeAmple2,
      solutionAfterAmpole2: solutionAfterAmpole2,
      solutionBeforeReadyMadeCosmetic: solutionBeforeReadyMadeCosmetic,
      solutionAfterReadyMadeCosmetic: solutionAfterReadyMadeCosmetic
    }
  end
end
