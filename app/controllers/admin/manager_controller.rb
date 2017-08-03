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
    scoped = scoped.where(ch_cd: @ch_cd) if !@ch_cd.blank?

    @users = scoped.order("shop_cd asc")
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def add_manager
  end

  def create
    admin_user = AdminUser.new(permitted_params)
    admin_user.ch_cd = params[:ch_cd].upcase
    serial = 1
    if AdminUser.count > 1
      serial = AdminUser.count + 1
    end
    admin_user.id = serial

    if admin_user.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def duplication
    admin_user = AdminUser.find_by(email: params[:email])
    if admin_user.present?
      render json: {}, status: :bad_request
    else
      render json: {}, status: :ok
    end
  end

  def edit_manager
    @admin_user = AdminUser.where(email: params[:email]).first
  end

  def update
    admin_user = AdminUser.where(email: params[:email]).first
    admin_user.update(permitted_params)
    if params.has_key?(:ch_cd)
      admin_user.ch_cd = params[:ch_cd].upcase
    end

    if admin_user.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def login_history
    @history = LoginHistory.all.order("created_at desc")
    @history = Kaminari.paginate_array(@history).page(params[:page]).per(5)
  end

  def delete
    admin_user = AdminUser.where(email: params[:email]).first
    Rails.logger.info admin_user
    if admin_user.delete
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:email, :password, :ch_cd, :shop_cd)
  end
end
