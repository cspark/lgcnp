require 'rubygems'
require 'composite_primary_keys'

class FcadminUser < ApplicationRecord
  self.table_name = "fcadmin_user" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :admin_id,:encrypted_password  if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      admin_id: admin_id,
      pw_uptdate: pw_uptdate,
      create_date: create_date,
      last_login_date: last_login_date
    }
  end

  def to_api_hash_encrypted_pw
    {
      admin_id: admin_id,
      encrypted_pw: encrypted_pw,
      pw_uptdate: pw_uptdate,
      create_date: create_date,
      last_login_date: last_login_date
    }
  end

  def self.list(admin_id: nil)
    scoped = FcadminUser.all
    scoped = scoped.where(admin_id: admin_id) if admin_id.present?
    scoped.order('create_date DESC')
  end
end
