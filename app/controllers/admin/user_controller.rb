require 'iconv'

class Admin::UserController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    custserial = params[:custserial]
    @custserial = custserial

    @count = 0
    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    if ch_cd == ""
      fcdata_list = Fcdata.where("ch_cd LIKE ?", "%#{ch_cd}%").where("shop_cd LIKE ?", "%#{shop_cd}%")
    else
      fcdata_list = Fcdata.where(ch_cd: ch_cd).where("shop_cd LIKE ?", "%#{shop_cd}%")
    end
    custserial_array = fcdata_list.where("CAST(custserial AS INT) < ? ", 1001).pluck(:custserial).uniq
    custserial_array2 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 1001, 2001).pluck(:custserial).uniq
    # custserial_array = custserial_array + custserial_array2
    measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

    Rails.logger.info "user index!!!"
    Rails.logger.info ch_cd

    scoped = Custinfo.all
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    if params.has_key?(:search) && params[:search].length != 0
      @search = params[:search]
      if ch_cd == ""
        @users = scoped.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
        @users2 = scoped.where(custserial: custserial_array2).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
      else
        @users = scoped.where(custserial: custserial_array).where(measureno: measureno_array).where(ch_cd: ch_cd).where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
        @users2 = scoped.where(custserial: custserial_array2).where(measureno: measureno_array).where(ch_cd: ch_cd).where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
      end
      @users = @users.or(@users2)
    else
      @search = ""
      if ch_cd == ""
        @users = scoped.where(custserial: custserial_array).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where.not(lastanaldate: nil).order("lastanaldate desc")
        @users2 = scoped.where(custserial: custserial_array2).where(measureno: measureno_array).where("ch_cd LIKE ?", "%#{ch_cd}%").where.not(lastanaldate: nil).order("lastanaldate desc")
      else
        @users = scoped.where(custserial: custserial_array).where(measureno: measureno_array).where(ch_cd: ch_cd).where.not(lastanaldate: nil).order("lastanaldate desc")
        @users2 = scoped.where(custserial: custserial_array2).where(measureno: measureno_array).where(ch_cd: ch_cd).where.not(lastanaldate: nil).order("lastanaldate desc")
      end
      @users = @users.or(@users2)
    end

    @count = @users.count
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)

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

  def destroy
    user = Custinfo.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno]).first

    fcdata = Fcdata.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
    fcdata.delete if !fcdata.nil?
    fctabletinterview = Fctabletinterview.where(custserial: params[:id], ch_cd: params[:ch_cd], fcdata_id: params[:measureno]).first
    if !fctabletinterview.nil?
      fcafterinterview = Fcafterinterview.where(custserial: params[:id], tablet_interview_id: fctabletinterview.tablet_interview_id).first
      fcafterinterview.delete if !fcafterinterview.nil?
      fctabletinterview.delete
    end
    fcpos = Fcpos.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
    fcpos.delete if !fcpos.nil?
    fcinterview = Fcinterview.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
    fcinterview.delete if !fcinterview.nil?

    if user.delete
      render json: {}, status: 200
    else
      render json: {}, status: 404
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :userId, :ch_cd, :measureno, :phone, :birthyy, :birthmm, :birthdd, :email, :is_agree_privacy, :is_agree_thirdparty_info, :is_agree_marketing, :is_agree_after)
  end
end
