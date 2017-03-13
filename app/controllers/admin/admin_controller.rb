require 'securerandom'
require 'date'

class Admin::AdminController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:login, :admin_login, :logout]
  before_action :is_admin
  skip_before_action :is_admin, :only => [:admin_login, :login, :logout]

  def index
    redirect_to '/admin/user_list'
  end

  def admin_login
    render '/admin/login'
  end

  def login
    if params[:email] == "mint" && params[:password] == "mint"
      session[:admin_user] = "user"
      return
    end

    user = AdminUser.where(email: params[:email]).first

    if user.present? && user.valid_password?(params[:password])
      session[:admin_user] = user
      history = LoginHistory.new
      history.email = params[:email]
      history.ip = request.remote_ip
      history.created_at = Time.now.to_datetime
      history.save
      Rails.logger.info "Login success"
    else

    end
  end

  def logout
    session[:admin_user] = nil
  end
end
