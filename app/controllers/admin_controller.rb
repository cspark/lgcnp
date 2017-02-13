require 'securerandom'

class AdminController < AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:login, :admin_login, :logout]
  before_action :is_admin
  skip_before_action :is_admin, :only => [:admin_login, :login, :logout]


  def index

  end

  def admin_login
    render 'login'
  end

  def login
    user = AdminUser.where(email: params[:email]).first

    if user.present? && user.valid_password?(params[:password])
      session[:admin_user] = user
      Rails.logger.info "Login success"
    else

    end
  end

  def logout
    session[:admin_user] = nil
  end
end
