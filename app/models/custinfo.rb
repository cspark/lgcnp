class Custinfo < ApplicationRecord
  self.table_name = "custinfo"
  self.set_primary_key "custserial"

  def to_api_hash
    {
      serial: custserial,
      custname: custname,
      sex: sex,
      age: age,
      birthyy: birthyy,
      birthmm: birthmm,
      birthdd: birthdd,
      phone: phone,
      update: uptdate
    }
  end
end
