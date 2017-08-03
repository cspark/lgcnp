class Admin::PrivacyController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    start_date = params[:start_date]
    end_date = params[:end_date]
    ch_cd = params[:select_channel] if !params[:select_channel].nil?
    shop_cd = params[:select_shop]
    @ch_cd = ch_cd if !ch_cd.blank?
    @shop_cd = shop_cd if !shop_cd.blank?
    @search = ""
    @search = params[:search] if params.has_key?(:search) && params[:search].length != 0

    @today = Date.today
    @start_date = "2017-01-25"
    @end_date = @today
    @start_date = start_date if !start_date.blank?
    @end_date = end_date if !end_date.blank?

    Rails.logger.info "!!!!"
    Rails.logger.info @start_date
    Rails.logger.info @end_date
    temp_end_date = @end_date.to_date + 1.day

    scoped = Privacyaccesshistory.all.order("id desc")
    scoped = scoped.where("email LIKE ?", "%#{@search}%") if !@search.blank?
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(created_at) >= ? AND to_date(created_at) < ?", @start_date.to_date, temp_end_date)
    else
      scoped = scoped.where("created_at >= ? AND created_at < ?", @start_date.to_date, temp_end_date)
    end
    @privacies = []
    scoped.each do |privacy|
      is_contain = true
      adminUser = AdminUser.where(email: privacy.email).first
      if !@ch_cd.nil? && @ch_cd != "ALL" && @ch_cd != adminUser.ch_cd
        is_contain = false
      end

      if !@shop_cd.nil? && @shop_cd != adminUser.shop_cd
        is_contain = false
      end

      if is_contain == true
        @privacies << privacy
      end
    end

    @count = @privacies.count

    @privacies = Kaminari.paginate_array(@privacies).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  private
  def permitted_params
    params.permit(:email, :adminuser_id, :ch_cd, :created_at, :updated_at)
  end
end
