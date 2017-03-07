class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @search = ""
    if params.has_key?(:search) && params[:search].length != 0
      if Rails.env.production? || Rails.env.staging?
        @search = params[:search]
      else
        @search = URI.decode(params[:search]) if !params[:search].blank?
      end
      users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{@search}%").order("lastanaldate desc")
      user_custserials = []
      users.each do |user|
        user_custserials.push(user.custserial)
      end
      @fcpos = Fcpos.where(custserial: user_custserials)
    else
      @fcpos = Fcpos.all.order("uptdate desc")
    end

    @fcpos_excel = @fcpos
    if params.has_key?(:page)
      page = params[:page]
    else
      page = 1
    end
    @fcpos = Kaminari.paginate_array(@fcpos).page(page).per(5)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
    @fcpos = Fcpos.where(custserial: params[:userId], measureno: params[:measureno]).first
  end
end
