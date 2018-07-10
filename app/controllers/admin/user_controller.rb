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

    @is_admin_init = true
    # if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") &&
    if params.has_key?(:select_address)
      @is_admin_init = false
    end

    if params.has_key? :is_delete_cust and params[:is_delete_cust] == "T"
      @is_delete_cust = true
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil?
    select_address = params[:select_address] if !params[:select_address].nil? && params[:select_address] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd if !ch_cd.blank?
    @select_address = select_address if !select_address.blank?

    # if !@is_admin_init
    Rails.logger.info "!is_admin_init  2"

    scoped = Custinfo.all
    # scoped = scoped.where("delete_at IS NULL")
    scoped = scoped.where("shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?
    scoped = scoped.where(ch_cd: @ch_cd) if !@ch_cd.blank? && @ch_cd != "ALL"
    scoped = scoped.where(address: @select_address) if !@select_address.blank?
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(is_delete_cust: "T") if @is_delete_cust
    @search = ""
    @search = params[:search] if params.has_key?(:search) && params[:search].length != 0
    scoped = scoped.where("custname LIKE ?", "%#{@search}%") if !@search.blank?

    lastanaldate_not_nil_user = scoped.where.not(lastanaldate: nil).order("lastanaldate desc")
    lastanaldate_nil_user = scoped.where(lastanaldate: nil).order("lastanaldate desc")


    @users = lastanaldate_not_nil_user + lastanaldate_nil_user
    # else
    #   scoped = Custinfo.where(ch_cd: @ch_cd)
    #   # scoped = scoped.where("delete_at IS NULL")
    #
    #   lastanaldate_not_nil_user = scoped.where.not(lastanaldate: nil).order("lastanaldate desc")
    #   lastanaldate_nil_user = scoped.where(lastanaldate: nil).order("lastanaldate desc")
    #   @users = lastanaldate_not_nil_user + lastanaldate_nil_user
    # end
    Rails.logger.info "users count!!"
    Rails.logger.info "users count : #{@users.count}"

    @all_users = @users
    Rails.logger.info "All users count : #{@all_users.count}"

    @users = @users.uniq
    @count = @users.count
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)

    respond_to do |format|
      format.html
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

  def delete_at_added
    user = Custinfo.where(custserial: params[:userId], ch_cd: params[:ch_cd], measureno: params[:measureno]).first

    t = Time.now

    time_string = t.strftime("%Y")[2,4]
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%m"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%d"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%H"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%M"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%S"))

    user.delete_at = time_string

    user.custname = ""
    user.birthyy = ""
    user.birthmm = ""
    user.birthdd = ""
    user.age = ""
    user.phone = ""
    user.lastanaldate = ""
    user.is_agree_privacy = "F"
    user.is_agree_after = "F"
    user.is_agree_marketing = "F"
    user.is_agree_thirdparty_info = "F"
    user.is_agree_privacy_residence = "F"
    user.n_cust_id = nil
    user.address = ""
    user.uptdate = ""
    user.measureno = ""
    user.gene_barcode = ""
    user.ch_cd = " "
    user.shop_cd = ""
    user.sex = ""

    if user.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :userId, :ch_cd, :measureno, :phone, :birthyy, :birthmm, :birthdd, :email, :is_agree_privacy, :is_agree_thirdparty_info, :is_agree_marketing, :is_agree_after, :is_agree_privacy_residence)
  end
end
