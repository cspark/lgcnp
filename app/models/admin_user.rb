class AdminUser < ApplicationRecord
  self.table_name = "adminuser" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :email, :id if Rails.env.production? || Rails.env.staging?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
