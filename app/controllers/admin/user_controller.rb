require 'iconv'

class Admin::UserController < Admin::AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    if params.has_key?(:search) && params[:search].length != 0
      @search = params[:search]
      @users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc").page(params[:page]).per(6)
    else
      @search = ""
      @users = Custinfo.where(ch_cd: "CNP").where.not(lastanaldate: nil).order("lastanaldate desc").page(params[:page]).per(6)
    end

    if params.has_key?(:isExcel) && params[:isExcel] == 'true'
      @users.each do |user|
        Rails.logger.info "!!!!"
        Rails.logger.info user.custname
        user.custname = URI.decode(user.custname)
        if user.sex.include?("M")
          user.sex = "남자"
        else
          user.sex = "여자"
        end
        Rails.logger.info user.custname
      end
    end

    respond_to do |format|
      format.html
      # format.csv { send_data Custinfo.to_csv(@users) }
      format.xls
    end
  end

  def show
    userId = params[:userId]
    @user = Custinfo.where(custserial: userId).first
  end
end
