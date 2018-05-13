class Admin::MigenAgreeController < Admin::AdminApplicationController
  def index
    @custserial = params[:custserial]
    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end
    ch_cd = params[:select_channel] if !params[:select_channel].nil?
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd if !ch_cd.blank?

    scoped = FcAgreeMigen.all
    scoped = scoped.where("shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?
    scoped = scoped.where(ch_cd: @ch_cd) if !@ch_cd.blank? && @ch_cd != "ALL"
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    @search = ""
    @search = params[:search] if params.has_key?(:search) && params[:search].length != 0
    scoped = scoped.where("custname LIKE ?", "%#{@search}%") if !@search.blank?

    @count = scoped.count
    @all = scoped
    @migen_agree = scoped.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end
