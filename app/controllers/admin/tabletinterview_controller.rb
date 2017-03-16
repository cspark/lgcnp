class Admin::TabletinterviewController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @start_date = Fctabletinterview.all.order('uptdate asc').first.uptdate[0,10]
    @end_date = Date.today
    @today = Date.today

    select_sex = params[:select_sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    name = params[:name]
    custserial = params[:custserial]
    start_birthyy = params[:start_birthyy]
    end_birthyy = params[:end_birthyy]
    start_birthmm = params[:start_birthmm]
    end_birthmm = params[:end_birthmm]
    select_channel = params[:select_channel]
    select_mode = params[:select_mode]
    select_makeup = params[:select_makeup]
    select_area = params[:select_area]

    @select_sex = select_sex
    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @name = name
    @custserial = custserial
    @start_birthyy = start_birthyy
    @end_birthyy = end_birthyy
    @start_birthmm = start_birthmm
    @end_birthmm = end_birthmm
    @select_channel = select_channel
    @select_mode = select_mode
    @select_makeup = select_makeup
    @select_area = select_area

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @min_birthmm = 1
    max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @max_birthyy = max_age_custinfo.birthyy
    @max_birthmm = 12

    @tabletinterviews = []
    if Rails.env.production? || Rails.env.staging?
      is_contain = true
      scoped = Fctabletinterview.all
      temp_end_date = @end_date.to_date+1.day
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.blank? && @select_channel.downcase != "all"

      if !@select_mode.blank?
        if @select_mode.downcase != "all"
          if @select_mode == "quick"
            scoped = scoped.where(is_quick_mode: "T")
          end
        end
      end

      if !@select_makeup.blank?
        if @select_makeup.downcase != "all"
          scoped = scoped.where(is_make_up: @select_makeup)
        end
      end

      scoped = scoped.order("uptdate desc")

      Rails.logger.info scoped.count

      scoped.each do |tabletinterview|
        custinfo = Custinfo.where(custserial: tabletinterview.custserial).first
        Rails.logger.info custinfo.custname
        is_contain = true

        if !@name.blank?
          if !custinfo.custname.include? @name
            Rails.logger.info "NAME FALSE"
            is_contain = false
          end
        end

        if @select_sex != "all"
          if custinfo.sex != @select_sex
            Rails.logger.info "SEX FALSE"
            is_contain = false
          end
        end

        if !@start_age.blank? && !@end_age.blank?
          temp_age = Time.current.year.to_i - custinfo.birthyy.to_i
          if temp_age < @start_age.to_i || temp_age > @end_age.to_i
            Rails.logger.info "AGE FALSE"
            is_contain = false
          end
        end

        if !@start_birthyy.blank? && !@end_birthyy.blank?
          if custinfo.birthyy.to_i < @start_birthyy.to_i || custinfo.birthyy.to_i > @end_birthyy.to_i
            Rails.logger.info "BIRTHYY FALSE"
            is_contain = false
          end
        end

        if !@start_birthmm.blank? && !@end_birthmm.blank?
          if custinfo.birthmm.to_i < @start_birthmm.to_i || custinfo.birthmm.to_i > @end_birthmm.to_i
            Rails.logger.info "BIRTHMM FALSE"
            is_contain = false
          end
        end

        if is_contain == true
          @tabletinterviews << tabletinterview
          Rails.logger.info "INSERT to array"
          Rails.logger.info @tabletinterviews.count
        end
      end

      @tabletinterviews_excel = @tabletinterviews
      @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)
      respond_to do |format|
        format.html
        format.xlsx
      end
    else
      @tabletinterviews = Fctabletinterview.all
      @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)
      @tabletinterviews_excel = Fctabletinterview.all
      respond_to do |format|
        format.html
        format.xlsx
      end
    end
  end

  def show
    @tabletinterview = Fctabletinterview.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def edit
    @tabletinterview = Fctabletinterview.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def update
    fctabletinterview = Fctabletinterview.where(custserial: params[:id], ch_cd: params[:ch_cd], fcdata_id: params[:fcdata_id]).first
    fctabletinterview.update(permitted_params)
    if fctabletinterview.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:memo)
  end
end
