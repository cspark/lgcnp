class Admin::ScheduleController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    # Time.current.year
    if params.has_key?(:isExcel) && params[:isExcel]
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user] if session[:admin_user] != "user" && !session[:admin_user].nil?
      history.id = serial
      history.adminuser_id = user['id']
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.save
    end

    if !params[:select_date].blank?
      @select_date = params[:select_date]
    else
      @select_date = Date.today
    end

    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    search = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    search = params[:search] if params.has_key?(:search) && params[:search].length != 0
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd
    @search = search

    select_year = @select_date.to_s.split("-")[0]
    select_mmdd = @select_date.to_s.split("-")[1]+@select_date.to_s.split("-")[2]

    scoped = Fcschedule.where("reserve_yyyy = ?", select_year)
    scoped = scoped.where("reserve_mmdd = ?", select_mmdd)
    scoped = scoped.where(ch_cd: ch_cd) if !ch_cd.blank?
    scoped = scoped.where(shop_cd: shop_cd) if !shop_cd.blank?
    scoped = scoped.where("custname LIKE ?", "%#{@search}%")
    @fcschedules = scoped.order("reserve_hhmm asc")

    @fcschedules_excel = @fcschedules
    @fcschedules = Kaminari.paginate_array(@fcschedules).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @fcschedule = Fcschedule.list(ch_cd: params[:ch_cd], shop_cd: params[:shop_cd], reserve_yyyy: params[:reserve_yyyy], reserve_mmdd: params[:reserve_mmdd], reserve_hhmm: params[:reserve_hhmm]).first
  end
end
