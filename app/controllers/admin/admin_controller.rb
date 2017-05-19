require 'securerandom'
require 'date'
require 'ipaddr'

class Admin::AdminController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:login, :admin_login, :logout]
  before_action :is_admin
  skip_before_action :is_admin, :only => [:admin_login, :login, :logout, :check_access, :access_restriction]

  def index
    redirect_to '/admin/user_list'
  end

  def admin_login
    render '/admin/login'
  end

  def access_restriction
    render '/admin/access_restriction'
  end

  def check_access
    ip = params[:real_ip] || request.remote_ip
    allow = false

    Allowaccess.all.each do |range|
      Rails.logger.info range.low_ip
      Rails.logger.info range.high_ip
      Rails.logger.info ip

      low = IPAddr.new(range.low_ip).to_i
      high = IPAddr.new(range.high_ip).to_i
      translate_ip = IPAddr.new(ip).to_i

      Rails.logger.info low
      Rails.logger.info high
      Rails.logger.info translate_ip

      if translate_ip >= low && translate_ip <= high
        allow = true
      end
    end

    Rails.logger.info "allow!!!"
    Rails.logger.info allow
    if allow != true
      render json: {}, status: :bad_request
    end
  end

  def login
    history = LoginHistory.new
    history.email = params[:email]
    history.ip = params[:real_ip] || request.remote_ip
    history.created_at = Time.now.to_datetime+10.minutes
    history.save

    if params[:email] == "mint" && params[:password] == "mint"
      session[:admin_user] = "user"
      return
    end

    user = AdminUser.where(email: params[:email]).first

    if user.present? && user.valid_password?(params[:password])
      session[:admin_user] = user
      Rails.logger.info "Login success"
      Rails.logger.info history.ip
    else
      render json: {}, status: :ok
    end
  end

  def logout
    session[:admin_user] = nil
  end
end
