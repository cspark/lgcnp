class FcAgreeMigen < ApplicationRecord
  self.table_name = "fc_agree_migen"
  self.primary_key = :custserial

  # custserial: decimal,
  # ch_cd: string,
  # shop_cd: string,
  # is_private: string,
  # private_agree_dt: string,
  # private_retract_dt: string,
  # is_consignment: string,
  # consignment_agree_dt: string,
  # consignment_retract_dt: string,
  # is_skin_residence: string,
  # skin_residence_agree_dt: string,
  # skin_residence_retract_dt: string,
  # is_sensitive: string,
  # sensitive_agree_dt: string,
  # sensitive_retract_dt: string,
  # is_private_third: string,
  # private_third_agree_dt: string,
  # private_third_retract_dt: string,
  # is_sensitive_third: string,
  # sensitive_third_agree_dt: string,
  # sensitive_third_retract_dt: string,
  # is_marketing: string,
  # marketing_agree_dt: string,
  # marketing_retract_dt: string
  def to_api_hash
    {
      serial: custserial,
      ch_cd: ch_cd,
      shop_cd: shop_cd,
      is_private: is_private,
      private_agree_dt: private_agree_dt,
      private_retract_dt: private_retract_dt,
      is_consignment: is_consignment,
      consignment_agree_dt: consignment_agree_dt,
      consignment_retract_dt: consignment_retract_dt,
      is_skin_residence: is_skin_residence,
      skin_residence_agree_dt: skin_residence_agree_dt,
      skin_residence_retract_dt: skin_residence_retract_dt,
      is_sensitive: is_sensitive,
      sensitive_agree_dt: sensitive_agree_dt,
      sensitive_retract_dt: sensitive_retract_dt,
      is_private_third: is_private_third,
      private_third_agree_dt: private_third_agree_dt,
      private_third_retract_dt: private_third_retract_dt,
      is_sensitive_third: is_sensitive_third,
      sensitive_third_agree_dt: sensitive_third_agree_dt,
      sensitive_third_retract_dt: sensitive_third_retract_dt,
      is_marketing: is_marketing,
      marketing_agree_dt: marketing_agree_dt,
      marketing_retract_dt: marketing_retract_dt
    }
  end
end
