require 'iconv'

class Admin::UserController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    # if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user"
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Custinfo"
      history.save
    end

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
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && params.has_key?(:select_channel) != true
      @is_admin_init = true
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil?
    select_address = params[:select_address] if !params[:select_address].nil? && params[:select_address] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd if !ch_cd.blank?
    @select_address = select_address if !select_address.blank?

    if !@is_admin_init
      scoped = Custinfo.all
      if (@ch_cd == "CNP" || @ch_cd == "CLAB" || @ch_cd == "CNPR" || @ch_cd == "RLAB")
        fcdata_list = Fcdata.all
        fcdata_list = fcdata_list.where(shop_cd: @shop_cd) if !@shop_cd.blank?
        custserial_array = fcdata_list.where("CAST(custserial AS INT) < ? ", 1001).pluck(:custserial).uniq
        custserial_array2 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 1000, 2001).pluck(:custserial).uniq
        custserial_array3 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 2000, 3001).pluck(:custserial).uniq
        custserial_array4 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 3000, 4001).pluck(:custserial).uniq
        custserial_array5 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 4000, 5001).pluck(:custserial).uniq
        custserial_array6 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 5000, 6001).pluck(:custserial).uniq
        custserial_array7 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 6000, 7001).pluck(:custserial).uniq
        custserial_array8 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 7000, 8001).pluck(:custserial).uniq
        custserial_array9 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 8000, 9001).pluck(:custserial).uniq
        custserial_array10 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 9000, 10001).pluck(:custserial).uniq

        array_result = scoped.where(custserial: custserial_array)
        array_result2 = scoped.where(custserial: custserial_array2)
        array_result3 = scoped.where(custserial: custserial_array3)
        array_result4 = scoped.where(custserial: custserial_array4)
        array_result5 = scoped.where(custserial: custserial_array5)
        array_result6 = scoped.where(custserial: custserial_array6)
        array_result7 = scoped.where(custserial: custserial_array7)
        array_result8 = scoped.where(custserial: custserial_array8)
        array_result9 = scoped.where(custserial: custserial_array9)
        array_result10 = scoped.where(custserial: custserial_array10)

        Rails.logger.info "======="
        Rails.logger.info array_result7
        scoped = array_result.or(array_result2).or(array_result3).or(array_result4).or(array_result5).or(array_result6).or(array_result7).or(array_result8).or(array_result9).or(array_result10)
      else
        scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
      end
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.where(ch_cd: @ch_cd) if !@ch_cd.blank? && @ch_cd != "ALL"
      scoped = scoped.where(address: @select_address) if !@select_address.blank?
      @search = ""
      @search = params[:search] if params.has_key?(:search) && params[:search].length != 0
      scoped = scoped.where("custname LIKE ?", "%#{@search}%") if !@search.blank?

      lastanaldate_not_nil_user = scoped.where.not(lastanaldate: nil).order("lastanaldate desc")
      lastanaldate_nil_user = scoped.where(lastanaldate: nil).order("lastanaldate desc")
      @users = lastanaldate_not_nil_user + lastanaldate_nil_user
    else
      @users = Custinfo.where(ch_cd: @ch_cd)
    end

    @all_users = @users
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

  def fcmodecnt
    @fcmodecnt = Fcmodecnt.all
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :userId, :ch_cd, :measureno, :phone, :birthyy, :birthmm, :birthdd, :email, :is_agree_privacy, :is_agree_thirdparty_info, :is_agree_marketing, :is_agree_after)
  end
end
