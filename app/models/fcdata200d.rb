require 'rubygems'
require 'composite_primary_keys'

class Fcdata < ApplicationRecord
  self.table_name = "fcdata_200d" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial,:ch_cd,:measureno if Rails.env.production? || Rails.env.staging?

end
