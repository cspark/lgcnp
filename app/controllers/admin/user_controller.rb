require 'iconv'

class Admin::UserController < AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
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
end
