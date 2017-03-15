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
    @user = Custinfo.where(custserial: params[:userId], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
  end

  def edit
    @user = Custinfo.where(custserial: params[:userId], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
  end

  def update
    user = Custinfo.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
    user.update(permitted_params)
    if user.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :userId, :ch_cd, :measureno, :phone, :birthyy, :birthmm, :birthdd, :email, :is_agree_privacy, :is_agree_thirdparty_info, :is_agree_marketing, :is_agree_after)
  end
end
