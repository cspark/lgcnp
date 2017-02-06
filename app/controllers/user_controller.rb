require 'iconv'

class UserController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:index, :show]
  before_action :is_admin

  def index
    Rails.logger.info "User count"
    if params.has_key?(:search) && params[:search].length != 0
      Rails.logger.info params[:search]
      @users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc").page(params[:page]).per(6)
    else
      @users = Custinfo.where(ch_cd: "CNP").where.not(lastanaldate: nil).order("lastanaldate desc").page(params[:page]).per(6)
    end
  end

  def show
    userId = params[:userId]
    @user = Custinfo.where(custserial: userId).first
  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
