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
    select_mode = params[:select_mode]
    select_makeup = params[:select_makeup]
    select_area = params[:select_area]
    @params_filter = params[:select_filter]

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
    @select_mode = select_mode
    @select_makeup = select_makeup
    @select_area = select_area
    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    min_age_custinfo = Custinfo.where(ch_cd: ch_cd).where.not(birthyy: nil).order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @min_birthmm = 1
    max_age_custinfo = Custinfo.where(ch_cd: ch_cd).order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @max_birthyy = max_age_custinfo.birthyy
    @max_birthmm = 12

    @tabletinterviews = []
    if Rails.env.production? || Rails.env.staging?
      is_contain = true

      fcdata_list = Fcdata.where("ch_cd LIKE ?", "%#{ch_cd}%").where("shop_cd LIKE ?", "%#{@shop_cd}%")
      serial_array = fcdata_list.where("custserial < ? ", 1001).pluck(:custserial).uniq
      serial_array2 = fcdata_list.where("custserial > ? AND custserial < ? ", 1000, 2001).pluck(:custserial).uniq
      measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

      Rails.logger.info serial_array
      Rails.logger.info serial_array2
      scoped = Fctabletinterview.where(custserial: serial_array).where(fcdata_id: measureno_array)
      scoped = scoped.or(Fctabletinterview.where(custserial: serial_array2).where(fcdata_id: measureno_array))
      temp_end_date = @end_date.to_date+1.day
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.where(ch_cd: @ch_cd) if !@ch_cd.blank? && @ch_cd != "ALL"


      if @select_filter == []
        @excel_name = ["이름","시리얼","진단 날짜","채널","피부타입","진단으로 나온 솔루션 1","최종으로 선택된 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 2","진단으로 나온 세럼","최종으로 선택된 세럼",
        "진단으로 나온 앰플 1","최종으로 선택된 앰플 1","진단으로 나온 앰플 1","최종으로 선택된 앰플 2","진단으로 나온 화장품","최종으로 선택된 화장품",
        "A1","A2","A3","B1","B2","B3","B4","C1","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10","모공 점수","트러블 점수","색소침착 점수","주름 점수","탄력 점수"]
      else
        @excel_name = ["이름","시리얼","진단 날짜","채널"]
        @select_filter.each do |filter|
          @excel_name << filter
        end
      end

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

      @count = @tabletinterviews.count
      @tabletinterviews_excel = @tabletinterviews
      @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)

      respond_to do |format|
        format.html
        format.xlsx
      end
    else
      @tabletinterviews = Fctabletinterview.all
      if @select_filter == []
        @excel_name = ["이름","시리얼","진단 날짜","채널","피부타입","진단으로 나온 솔루션 1","최종으로 선택된 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 2","진단으로 나온 세럼","최종으로 선택된 세럼",
        "진단으로 나온 앰플 1","최종으로 선택된 앰플 1","진단으로 나온 앰플 1","최종으로 선택된 앰플 2","진단으로 나온 화장품","최종으로 선택된 화장품",
        "A1","A2","A3","B1","B2","B3","B4","C1","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10","모공 점수","트러블 점수","색소침착 점수","주름 점수","탄력 점수"]
      else
        @excel_name = ["이름","시리얼","진단 날짜","채널"]
        @select_filter.each do |filter|
          @excel_name << filter
        end
      end

      @tabletinterviews_excel = @tabletinterviews
      @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)

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
