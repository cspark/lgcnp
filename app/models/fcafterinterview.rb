class Fcafterinterview < ApplicationRecord
  self.table_name = "fcafterinterview" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :after_interview_id if Rails.env.production?  || Rails.env.staging?
  belongs_to :custinfo, class_name: 'Custinfo', foreign_key: 'custserial'
  belongs_to :tabletinterview, class_name: 'Fctabletinterview', foreign_key: 'tablet_interview_id'
  attr_accessor :custname

end
