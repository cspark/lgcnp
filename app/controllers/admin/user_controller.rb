require 'iconv'

class Admin::UserController < Admin::AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    fcdata_list = Fcdata.where("ch_cd LIKE ?", "%#{ch_cd}%").where("shop_cd LIKE ?", "%#{shop_cd}%")
    custserial_array = fcdata_list.pluck(:custserial).uniq
    measureno_array = fcdata_list.pluck(:measureno).uniq

    if params.has_key?(:search) && params[:search].length != 0
      @search = params[:search]
      @users = Custinfo.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc").page(params[:page]).per(7)
      @all_users = Custinfo.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
    else
      @search = ""
      @users = Custinfo.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where.not(lastanaldate: nil).order("lastanaldate desc").page(params[:page]).per(7)
      @all_users = Custinfo.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where.not(lastanaldate: nil).order("lastanaldate desc")
    end

    respond_to do |format|
      format.html
      # format.csv { send_data Custinfo.to_csv(@users) }
      format.xlsx
    end

  end

  def show
    userId = params[:userId]
    @user = Custinfo.where(custserial: userId).first
  end
end
