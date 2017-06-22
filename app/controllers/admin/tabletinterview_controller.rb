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

    @is_agree_thirdparty_info = params[:is_agree_thirdparty_info] if !params[:is_agree_thirdparty_info].blank?
    @is_init = true
    if params[:select_channel].present?
      @is_init = false
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i + 1
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i + 1
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @tabletinterviews = []
    # if Rails.env.production? || Rails.env.staging?
    is_contain = true

    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where("faceno LIKE ?", "%#{@select_area}%") if !@select_area.blank? && @select_area != "all"
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    fcdata_list = scoped
    serial_array = fcdata_list.where("CAST(custserial AS INT) < ? ", 1001).pluck(:custserial).uniq
    serial_array2 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 1000, 2001).pluck(:custserial).uniq
    serial_array3 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 2000, 3001).pluck(:custserial).uniq
    measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

    scoped = Fctabletinterview.all
    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(ch_cd: @ch_array) if !@ch_array.blank? && @ch_array != ""
    scoped = scoped.where(is_quick_mode: @select_mode) if !@select_mode.blank? && @select_mode.downcase != "all"

    if @select_filter == []
      @excel_name = ["이름","시리얼","채널","진단 날짜","A1","A2","A3","B1","B2","B3","B4","C1","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
        "피부타입","진단으로 나온 솔루션 1","최종으로 선택된 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 2","진단으로 나온 세럼","최종으로 선택된 세럼",
        "진단으로 나온 앰플 1","최종으로 선택된 앰플 1","진단으로 나온 앰플 2","최종으로 선택된 앰플 2","진단으로 나온 화장품","최종으로 선택된 화장품",
        "모공 점수","트러블 점수","색소침착 점수","주름 점수","탄력 점수"]
    else
      @excel_name = ["이름","시리얼","진단 날짜","채널"]
      @select_filter.each do |filter|
        if filter.include?("skin_type")
          filter = "피부타입"
        elsif filter.include?("before_solution_1")
          filter = "진단으로 나온 솔루션 1"
        elsif filter.include?("after_solution_1")
          filter = "최종으로 선택된 솔루션 1"
        elsif filter.include?("before_solution_2")
          filter = "진단으로 나온 솔루션 2"
        elsif filter.include?("after_solution_2")
          filter = "최종으로 선택된 솔루션 2"
        elsif filter.include?("before_serum")
          filter = "진단으로 나온 세럼"
        elsif filter.include?("after_serum")
          filter = "최종으로 선택된 세럼"
        elsif filter.include?("before_ample_1")
          filter = "진단으로 나온 앰플 1"
        elsif filter.include?("after_ample_1")
          filter = "최종으로 선택된 앰플 1"
        elsif filter.include?("before_ample_2")
          filter = "진단으로 나온 앰플 2"
        elsif filter.include?("after_ample_2")
          filter = "최종으로 선택된 앰플 2"
        elsif filter.include?("before_made_cosmetic")
          filter = "진단으로 나온 화장품"
        elsif filter.include?("after_made_cosmetic")
          filter = "최종으로 선택된 화장품"
        elsif filter.include?("pr_graph")
          filter = "모공 점수"
        elsif filter.include?("sb_graph")
          filter = "트러블 점수"
        elsif filter.include?("pp_graph")
          filter = "색소침착 점수"
        elsif filter.include?("wr_graph")
          filter = "주름 점수"
        elsif filter.include?("el_graph")
          filter = "탄력 점수"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end

    if !@select_makeup.blank?
      if @select_makeup.downcase != "all"
        scoped = scoped.where(a_1: @select_makeup.to_i)
      end
    end

    scoped = scoped.order("uptdate desc")
    Rails.logger.info "scoped.count!!!!"
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

      if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info] != "T,F"
        if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("T")
          if custinfo.is_agree_thirdparty_info == "F"
            Rails.logger.info "is_agree_thirdparty_info1 FALSE"
            is_contain = false
          end
        end
        if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("F")
          if custinfo.is_agree_thirdparty_info == "T"
            Rails.logger.info "is_agree_thirdparty_info2 FALSE"
            is_contain = false
          end
        end
      end

      if !params.has_key?(:is_agree_thirdparty_info) || params[:is_agree_thirdparty_info] == ""
        Rails.logger.info "is_agree_thirdparty_info3 FALSE"
        is_contain = false
      end

      if is_contain == true
        @tabletinterviews << tabletinterview
        Rails.logger.info "INSERT to array"
        Rails.logger.info @tabletinterviews.count
      end
    end

    Rails.logger.info "@tabletinterviews.count!!!"
    Rails.logger.info @tabletinterviews.count

    @count = @tabletinterviews.count
    @tabletinterviews_excel = @tabletinterviews
    @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)
    Rails.logger.info "@excel_name!!!!"
    Rails.logger.info @excel_name
    Rails.logger.info @select_filter

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @tabletinterview = Fctabletinterview.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def beau_show
    @tabletinterview = Fcinterview.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(measureno: params[:measureno]).first
  end

  def cnpr_show
    Rails.logger.info params[:userId]
    Rails.logger.info params[:ch_cd]
    Rails.logger.info params[:fcdata_id]
    @tabletinterview = Fctabletinterviewrx.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def edit
    @tabletinterview = Fctabletinterview.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def cnpr_edit
    @tabletinterview = Fctabletinterviewrx.where(custserial: params[:userId]).where(ch_cd: params[:ch_cd]).where(fcdata_id: params[:fcdata_id]).first
  end

  def update
    fctabletinterview = Fctabletinterview.where(custserial: params[:id], ch_cd: params[:ch_cd], fcdata_id: params[:fcdata_id]).first
    fctabletinterview.memo = URI.encode(params[:memo])

    if fctabletinterview.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def beau_list
    @start_date = Fcinterview.all.order('uptdate asc').first.uptdate[0,10]
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
    select_area = ""
    select_area = params[:select_area] if !params[:select_area].blank? && params[:select_area] != "all"
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
    @select_area = params[:select_area]

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "BEAU").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "BEAU").order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i + 1
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i + 1
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @beau_interviews = []
    # if Rails.env.production? || Rails.env.staging?
    Rails.logger.info @select_mode
    scoped = Fcdata.where("faceno LIKE ?", "%#{select_area}%").where(ch_cd: @ch_array)
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    scoped = scoped.where(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode.downcase == "total"
    scoped = scoped.where.not(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode.downcase == "makeup"
    fcdata_list = scoped

    serial_array = fcdata_list.where("CAST(custserial AS INT) < ? ", 1001).pluck(:custserial).uniq
    serial_array2 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 1000, 2001).pluck(:custserial).uniq
    serial_array3 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 2000, 3001).pluck(:custserial).uniq
    measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

    scoped = Fcinterview.where(custserial: serial_array).where(measureno: measureno_array)
    scoped = scoped.or(Fcinterview.where(custserial: serial_array2).where(measureno: measureno_array)).or(Fcinterview.where(custserial: serial_array3).where(measureno: measureno_array))
    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(ch_cd: @ch_array) if !@ch_array.blank? && @ch_array != ""

    scoped = scoped.order("uptdate desc")

    Rails.logger.info "scoped.count!!!!!!"
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
        @beau_interviews << tabletinterview
        Rails.logger.info "INSERT to array"
        Rails.logger.info @beau_interviews.count
      end
    end

    Rails.logger.info "@beau_interviews.count!!!"
    Rails.logger.info @beau_interviews.count
    @count = @beau_interviews.count
    @beau_interviews_excel = @beau_interviews
    @beau_interviews = Kaminari.paginate_array(@beau_interviews).page(params[:page]).per(5)

    Rails.logger.info @beau_interviews_excel.count
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def cnpr_list
    @start_date = Fctabletinterviewrx.all.order('uptdate asc').first.uptdate[0,10]
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
    before_overlap = params[:before_overlap]
    after_overlap = params[:after_overlap]
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
    @before_overlap = before_overlap if !before_overlap.blank?
    @after_overlap = after_overlap if !after_overlap.blank?

    @is_init = true
    if params[:select_sex].present?
      @is_init = false
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "CNPR").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "CNPR").order("birthyy asc").first
    end
    # @min_age = 14
    # @max_age = 100
    # @min_birthyy = 2000
    # @max_birthyy = 1900
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i + 1
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i + 1
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @tabletinterviews = []
    is_contain = true

    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where("faceno LIKE ?", "%#{@select_area}%") if !@select_area.blank? && @select_area != "all"
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    fcdata_list = scoped
    serial_array = fcdata_list.where("CAST(custserial AS INT) < ? ", 1001).pluck(:custserial).uniq
    serial_array2 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 1000, 2001).pluck(:custserial).uniq
    serial_array3 = fcdata_list.where("CAST(custserial AS INT) > ? AND CAST(custserial AS INT) < ? ", 2000, 3001).pluck(:custserial).uniq
    measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

    Rails.logger.info "scoped.count!!!"
    Rails.logger.info scoped.count
    Rails.logger.info serial_array
    Rails.logger.info measureno_array

    scoped = Fctabletinterviewrx.where(custserial: serial_array).where(fcdata_id: measureno_array)
    scoped = scoped.or(Fctabletinterviewrx.where(custserial: serial_array2).where(fcdata_id: measureno_array)).or(Fctabletinterviewrx.where(custserial: serial_array3).where(fcdata_id: measureno_array))
    Rails.logger.info "scoped.count!!!"
    Rails.logger.info scoped.count

    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(mmode: @select_mode) if !@select_mode.blank? && @select_mode.downcase != "all"
    scoped = scoped.where.not(before_overlap: nil) if !@before_overlap.blank? && @before_overlap == "T"
    scoped = scoped.where.not(after_overlap: nil) if !@after_overlap.blank? && @after_overlap == "T"

    Rails.logger.info "scoped.count!!!"
    Rails.logger.info scoped.count
    if @select_filter == []
      @excel_name = ["이름","시리얼","채널","진단 날짜","A1","A2","A3","B1","B2","B3","B4","B5","B6","C1","D1","D2","D3","D4","D5","D6",
      "피부타입","진단으로 나온 솔루션 1","최종으로 선택된 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 2","추천 프로그램","최종 선택 프로그램",
      "턴오버 점수","각질 측정","스트레스 지수","맞춤제품 Step1","맞춤제품 Step2","맞춤제품 Step3","구매제품 Step1","구매제품 Step2","구매제품 Step3","추천 중복샷", "변경 중복샷",
      "트러블 점수","색소침착 점수","주름 점수","탄력 점수", "건조 점수"]
    else
      @excel_name = ["이름","시리얼","진단 날짜","채널"]
      @select_filter.each do |filter|
        if filter.include?("skin_type")
          filter = "피부타입"
        elsif filter.include?("before_solution_1")
          filter = "진단으로 나온 솔루션 1"
        elsif filter.include?("after_solution_1")
          filter = "최종으로 선택된 솔루션 1"
        elsif filter.include?("before_solution_2")
          filter = "진단으로 나온 솔루션 2"
        elsif filter.include?("after_solution_2")
          filter = "최종으로 선택된 솔루션 2"
        elsif filter.include?("recommand_program_step_1")
          filter = "맞춤제품 Step1"
        elsif filter.include?("recommand_program_step_2")
          filter = "맞춤제품 Step2"
        elsif filter.include?("recommand_program_step_3")
          filter = "맞춤제품 Step3"
        elsif filter.include?("purchase1")
          filter = "구매제품 Step1"
        elsif filter.include?("purchase2")
          filter = "구매제품 Step2"
        elsif filter.include?("purchase3")
          filter = "구매제품 Step3"
        elsif filter.include?("pr_graph")
          filter = "모공 점수"
        elsif filter.include?("sb_graph")
          filter = "트러블 점수"
        elsif filter.include?("pp_graph")
          filter = "색소침착 점수"
        elsif filter.include?("wr_graph")
          filter = "주름 점수"
        elsif filter.include?("el_graph")
          filter = "탄력 점수"
        elsif filter.include?("mo_graph")
          filter = "건조 점수"
        elsif filter.include?("turnover_value")
          filter = "턴오버 지수"
        elsif filter.include?("corneous_value")
          filter = "각질 측정"
        elsif filter.include?("stress_value")
          filter = "스트레스 지수"
        elsif filter.include?("before_overlap")
          filter = "추천 중복샷"
        elsif filter.include?("after_overlap")
          filter = "변경 중복샷"
        elsif filter.include?("memo")
          filter = "메모"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end

    scoped = scoped.order("uptdate desc")
    Rails.logger.info scoped.count

    scoped.each do |tabletinterview|
      custinfo = Custinfo.where(custserial: tabletinterview.custserial).first
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

    Rails.logger.info "@excel_name!!!!"
    Rails.logger.info @excel_name

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show_cnp_interview
  end

  def show_beau_interview
  end

  def show_cnpr_interview
  end

  private
  def permitted_params
    params.permit(:memo)
  end
end
