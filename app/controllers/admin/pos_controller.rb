class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @search = ""
    Rails.logger.info "list!!!"
    if params.has_key?(:search) && params[:search].length != 0
      Rails.logger.info "search!!!"
      Rails.logger.info params[:search]
      @search = params[:search]
      users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
      user_custserials = []
      users.each do |user|
        user_custserials.push(user.custserial)
      end
      @fcpos = Fcpos.where(custserial: user_custserials)
      Rails.logger.info @fcpos.count
    else
      Rails.logger.info "search nil!!!"
      @fcpos = Fcpos.all.order("uptdate desc")
      Rails.logger.info @fcpos.count
    end

    @fcpos_excel = @fcpos
    if params.has_key?(:page)
      page = params[:page]
    else
      page = 1
    end
    @fcpos = Kaminari.paginate_array(@fcpos).page(page).per(10)
    Rails.logger.info @fcpos.count
    
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
    @fcpos = Fcpos.where(custserial: params[:userId], measureno: params[:measureno]).first
  end
end
