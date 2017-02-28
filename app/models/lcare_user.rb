class LcareUser < ApplicationRecord
  # self.abstract_class = true
  establish_connection "lcare_production".to_sym
  self.table_name = "IF_TDC10" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      n_cust_id: n_cust_id,
      cust_hnm: cust_hnm,
      sex_cd: sex_cd,
      birth_year: birth_year,
      birth_mmdd: birth_mmdd,
      cell_phnno: cell_phnno,
      u_cust_yn: u_cust_yn
    }
  end

  def self.list(cust_hnm: nil, birth_year: nil, birth_mmdd: nil, cell_phnno: nil, page: 1, per: 3)
    Rails.logger.info "self.list!!!"
    scoped = LcareUser.all
    Rails.logger.info scoped
    scoped = scoped.where(cust_hnm: cust_hnm) if cust_hnm.present?
    scoped = scoped.where(birthyy: birthyy) if birthyy.present?
    scoped = scoped.where(birth_mmdd: birth_mmdd) if birth_mmdd.present?
    scoped = scoped.where(cell_phnno: cell_phnno) if cell_phnno.present?
    scoped.order('updated_at DESC').page(page).per(per)
  end
end
