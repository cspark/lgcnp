class Admin::ManagerController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    email = params[:email]
    ch_cd = params[:ch_cd]
    shop_cd = params[:shop_cd]

    @email = email if !email.blank?
    @ch_cd = ch_cd if ch_cd != "all" && !ch_cd.blank?
    @shop_cd = shop_cd  if !shop_cd.blank?

    scoped = AdminUser.all
    scoped = scoped.where("email LIKE?", "%#{@email}%") if !@email.blank?
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    scoped = scoped.where("ch_cd LIKE?", "%#{@ch_cd}%") if !@ch_cd.blank?

    @users = scoped.order("shop_cd asc")
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def add_manager
    @user = AdminUser.where(email: params[:email]).first
  end

  def login_history
    @history = LoginHistory.all
    @history = Kaminari.paginate_array(@history).page(params[:page]).per(5)
  end

end
