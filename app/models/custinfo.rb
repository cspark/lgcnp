class Custinfo < ApplicationRecord
  def to_api_hash
    {
      id: id,
      serial: self.SERIAL,
      custname: self.CUSTNAME,
      sex: self.SEX,
      age: self.AGE,
      birthyy: self.BIRTHYY,
      birthmm: self.BIRTHMM,
      birthdd: self.BIRTHDD,
      phone: self.PHONE,
      uptdate: self.UPTDATE
    }
  end
end
