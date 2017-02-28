class LcareUser < ApplicationRecord
  # self.abstract_class = true
  establish_connection(
    :adapter  => 'oracle_enhanced',
    :database => '(DESCRIPTION=(FAILOVER=on)(LOAD_BALANCE=off)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=165.244.88.137)(PORT=1528))(ADDRESS=(PROTOCOL=TCP)(HOST=165.244.88.138)(PORT=1528)))(CONNECT_DATA=(FAILOVER_MODE=(TYPE=select)(METHOD=basic)(RETRIES=20)(DELAY=3))(SERVER=dedicated)(SERVICE_NAME=LGCIO)))',
    :host     => '165.244.88.137',
    :username => 'ifuser',
    :password => 'ifuser!123',
    :port     => 1528
  )
  self.table_name = "if_tdc10" if Rails.env.production? || Rails.env.staging?

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
