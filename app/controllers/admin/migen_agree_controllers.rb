class Admin::MigenAgreeController < Admin::AdminApplicationController
  def index
    if session[:admin_user] == "user" || (session[:admin_user]['role'].present? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end
    @ch_cd  = params[:select_channel] if params[:select_channel].present?
    @shop_cd = params[:select_shop] if params[:select_shop].present?
    @custserial = params[:custserial]

    scoped = FcAgreeMigen.all
    scoped = scoped.where("shop_cd LIKE '%#{@shop_cd}%'") if @shop_cd.present?
    scoped = scoped.where(ch_cd: @ch_cd) if @ch_cd.present? && @ch_cd != "ALL"
    scoped = scoped.where(custserial: @custserial) if @custserial.present?

    @count = scoped.count
    @all = scoped
    @migen_agree = scoped.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @migen_agree = FcAgreeMigen.where(custserial: params[:custserial]).first
  end

  def edit
    @migen_agree = FcAgreeMigen.where(custserial: params[:custserial]).first
  end

  def update
    @migen_agree = FcAgreeMigen.where(custserial: params[:custserial]).first
    @migen_agree.assign_attributes(permitted_params)

    if @migen_agree.is_private_changed?
      if @migen_agree.is_private == "F"
        @migen_agree.private_retract_dt = Time.now()
      else
        @migen_agree.private_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_consignment_changed?
      if @migen_agree.is_consignment == "F"
        @migen_agree.consignment_retract_dt = Time.now()
      else
        @migen_agree.consignment_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_skin_residence_changed?
      if @migen_agree.is_skin_residence == "F"
        @migen_agree.skin_residence_retract_dt = Time.now()
      else
        @migen_agree.skin_residence_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_sensitive_changed?
      if @migen_agree.is_sensitive == "F"
        @migen_agree.sensitive_retract_dt = Time.now()
      else
        @migen_agree.sensitive_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_private_third_changed?
      if @migen_agree.is_private_third == "F"
        @migen_agree.private_third_retract_dt = Time.now()
      else
        @migen_agree.private_third_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_sensitive_third_changed?
      if @migen_agree.is_sensitive_third == "F"
        @migen_agree.sensitive_third_retract_dt = Time.now()
      else
        @migen_agree.sensitive_third_agree_dt = Time.now()
      end
    end
    if @migen_agree.is_marketing_changed?
      if @migen_agree.is_marketing == "F"
        @migen_agree.marketing_retract_dt = Time.now()
      else
        @migen_agree.marketing_agree_dt = Time.now()
      end
    end

    if @migen_agree.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :shop_cd, :is_private, :private_agree_dt, :private_retract_dt, :is_consignment, :consignment_agree_dt, :consignment_retract_dt, :is_skin_residence, :skin_residence_agree_dt, :skin_residence_retract_dt, :is_sensitive, :sensitive_agree_dt, :sensitive_retract_dt, :is_private_third, :private_third_agree_dt, :private_third_retract_dt, :is_sensitive_third, :sensitive_third_agree_dt, :sensitive_third_retract_dt, :is_marketing, :marketing_agree_dt, :marketing_retract_dt)
  end
end
