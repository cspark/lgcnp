class Fcavgdata < ApplicationRecord
  self.table_name = "fcavgdata" if Rails.env.production? || Rails.env.staging?
  
  def to_api_hash
    {
       n_index: n_index,
       age: age,
       pore: pore,
       wrinkle: wrinkle,
       spot_pl: spot_pl,
       spot_uv: spot_uv,
       elasticity: elasticity,
       porphyrin_ratio: porphyrin_ratio,
       e_sebum_t: e_sebum_t,
       e_sebum_u: e_sebum_u,
       moisture: moisture,
       e_porphyrin_t: e_porphyrin_t,
       e_porphyrin_u: e_porphyrin_u
    }
  end
end
