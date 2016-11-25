class Custinfo < ApplicationRecord
  self.table_name = "custinfo"

  def to_api_hash
    {
      id: id,
      serial: custserial,
      custname: custname,
      sex: sex,
      age: age,
      birthyy: birthyy,
      birthmm: birthmm,
      birthdd: birthdd,
      phone: phone,
      uptdate: update
    }
  end
end
