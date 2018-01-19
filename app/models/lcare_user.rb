class LcareUser < ApplicationRecord
  # self.abstract_class = true
  establish_connection(
    :adapter  => 'oracle_enhanced',
    :database => '(DESCRIPTION=(FAILOVER=on)(LOAD_BALANCE=off)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=165.244.88.138)(PORT=1531))(ADDRESS=(PROTOCOL=TCP)(HOST=165.244.88.137)(PORT=1531)))(CONNECT_DATA=(FAILOVER_MODE=(TYPE=select)(METHOD=basic)(RETRIES=20)(DELAY=3))(SERVER=dedicated)(SERVICE_NAME=LGCIM)))',
    :username => 'uregur',
    :password => '3edc4rfv!@'
  )
  self.table_name = "tb_cust_m" if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      n_cust_id: n_cust_id.to_i,
      cust_hnm: cust_hnm,
      sex_cd: sex_cd,
      birth_year: birth_year,
      birth_mmdd: birth_mmdd,
      cell_phnno: cell_phnno,
      active_mobile_yn: active_mobile_yn
    }
  end

  def self.list(cust_hnm: nil, birth_year: nil, birth_mmdd: nil, cell_phnno: nil, page: 1, per: 10)
    scoped = LcareUser.where(u_cust_yn: "Y")
    scoped = scoped.where("lower(cust_hnm) LIKE lower(?)", "%#{cust_hnm}%") if cust_hnm.present?
    scoped = scoped.where(birth_year: birth_year) if birth_year.present?
    scoped = scoped.where(birth_mmdd: birth_mmdd) if birth_mmdd.present?
    scoped = scoped.where(cell_phnno: cell_phnno) if cell_phnno.present?
    scoped.order('updt_dtm DESC').page(page).per(per)
  end
end
