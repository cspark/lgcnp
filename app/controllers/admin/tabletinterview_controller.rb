class Admin::TabletinterviewController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Fctabletinterview"
      history.save
    end

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
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @tabletinterviews = []
    # if Rails.env.production? || Rails.env.staging?
    is_contain = true

    scoped = Fctabletinterview.where(ch_cd: @ch_array)
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.faceno LIKE ?", "%#{@select_area}%") if !@select_area.blank? && @select_area != "all"
      scoped = scoped.joins(:fcdata).where("fcdata.shop_cd LIKE ?",  "#{@shop_cd}") if !@shop_cd.blank?
    end

    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fctabletinterview.uptdate) >= ? AND to_date(fctabletinterview.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(ch_cd: @ch_array) if !@ch_array.blank? && @ch_array != ""
    scoped = scoped.where(is_quick_mode: @select_mode) if !@select_mode.blank? && @select_mode.downcase != "all"

    if @select_filter == []
      @excel_name = ["이름","시리얼","채널","진단 날짜","진단횟수","생년월일","A1","A2","A3","B1","B2","B3","B4","C1","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
        "피부타입","진단으로 나온 솔루션 1(최근)","진단으로 나온 솔루션 2(최근)","진단으로 나온 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 1","최종으로 선택된 솔루션 2","진단으로 나온 세럼","최종으로 선택된 세럼",
        "진단으로 나온 앰플 1","최종으로 선택된 앰플 1","진단으로 나온 앰플 2","최종으로 선택된 앰플 2","진단으로 나온 화장품","최종으로 선택된 화장품","퀵모드 여부","베이스 제품 LOT 번호","앰플 1 LOT 번호","앰플 2 LOT 번호",
        "모공 점수","트러블 점수","색소침착 점수","주름 점수","탄력 점수"]
    else
      @excel_name = ["이름","시리얼","채널","진단 날짜","진단횟수","생년월일"]
      @select_filter.each do |filter|
        if filter.include?("skin_type")
          filter = "피부타입"
        elsif filter.include?("before_solution_1_new")
          filter = "진단으로 나온 솔루션 1(최근)"
        elsif filter.include?("before_solution_2_new")
          filter = "진단으로 나온 솔루션 2(최근)"
        elsif filter.include?("before_solution_1")
          filter = "진단으로 나온 솔루션 1"
        elsif filter.include?("before_solution_2")
          filter = "진단으로 나온 솔루션 2"
        elsif filter.include?("after_solution_1")
          filter = "최종으로 선택된 솔루션 1"
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
        elsif filter.include?("is_quick_mode")
          filter = "퀵 모드 여부"
        elsif filter.include?("base_lot")
          filter = "베이스 제품 LOT 번호"
        elsif filter.include?("ampoule_1_lot")
          filter = "앰플 1 LOT 번호"
        elsif filter.include?("ampoule_2_lot")
          filter = "앰플 2 LOT 번호"
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
      scoped = scoped.where(a_1: @select_makeup.to_i) if @select_makeup.downcase != "all"
    end

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil?
      scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sex}%") if @select_sex != "all"
      if !@start_age.blank? && !@end_age.blank?
        start_birthyy = Time.current.year.to_i - @start_age.to_i
        end_birthyy = Time.current.year.to_i - @end_age.to_i
        scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
      end

      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", @start_birthyy, @end_birthyy) if !@start_birthyy.blank? && !@end_birthyy.blank?
      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthmm) >= ? AND to_number(custinfo.birthmm) < ?", @start_birthmm, @end_birthmm) if !@start_birthmm.blank? && !@end_birthmm.blank?

      if params.has_key?(:is_agree_thirdparty_info)
        if params[:is_agree_thirdparty_info].empty?
          scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", nil)
        else
          scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", "%#{params[:is_agree_thirdparty_info]}%") if params[:is_agree_thirdparty_info] != "T,F"
        end
      end
    end

    scoped = scoped.order("fctabletinterview.uptdate desc") if Rails.env.production? || Rails.env.staging?
    @tabletinterviews = scoped

    @count = @tabletinterviews.count
    @tabletinterviews_excel = @tabletinterviews
    @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)

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
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Fctabletinterview"
      history.save
    end

    fcinterview = Fcinterview.all
    if fcinterview.count > 0
      fcinterview = fcinterview.order('uptdate asc')
      @start_date = fcinterview.first.uptdate[0,10]
    else
      @start_date = Date.today
    end
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
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i if !min_age_custinfo.nil?
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i if !max_age_custinfo .nil?
    @min_birthyy = min_age_custinfo.birthyy if !min_age_custinfo.nil?
    @max_birthyy = max_age_custinfo.birthyy if !max_age_custinfo .nil?
    @min_birthmm = 1
    @max_birthmm = 12

https://customizing.lgcare.co.kr/admin/beau_interview?start_date=2017-01-13&end_date=2018-02-09
&select_sex=all&start_age=&end_age=&name=&custserial=8725&start_birthyy=&end_birthyy=&start_birthmm=&end_birthmm=
&select_channel=BEAU,TMR,MART,LABO,ONEP&select_mode=all&select_area=all&select_filter=&select_shop=

    @beau_interviews = []
    fcdata_list = Fcdata.where("faceno LIKE ?", "%#{select_area}%").where(ch_cd: @ch_array)

    fcdata_list = fcdata_list.where(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode.downcase == "total"
    fcdata_list = fcdata_list.where.not(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode.downcase == "makeup"

    subquery = fcdata_list.select(:custserial)
    subquery_measureno = fcdata_list.select(:measureno)

    scoped = Fcinterview.where("fcinterview.custserial IN (#{subquery.to_sql}) AND fcinterview.measureno IN (#{subquery_measureno.to_sql})")
    scoped = scoped.where("fcinterview.shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?

    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fcinterview.uptdate) >= ? AND to_date(fcinterview.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where("fcinterview.shop_cd LIKE ?", "%#{@shop_cd}%") if !@shop_cd.nil?
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(ch_cd: @ch_array) if !@ch_array.blank? && @ch_array != ""

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil?

      scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sex}%") if @select_sex != "all"
      if !@start_age.blank? && !@end_age.blank?
        start_birthyy = Time.current.year.to_i - @start_age.to_i
        end_birthyy = Time.current.year.to_i - @end_age.to_i
        scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
      end

      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", @start_birthyy, @end_birthyy) if !@start_birthyy.blank? && !@end_birthyy.blank?
      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthmm) >= ? AND to_number(custinfo.birthmm) < ?", @start_birthmm, @end_birthmm) if !@start_birthmm.blank? && !@end_birthmm.blank?
      scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", "%#{params[:is_agree_thirdparty_info]}%") if params.has_key?(:is_agree_thirdparty_info)
    end
    scoped = scoped.order("fcinterview.uptdate desc")

    @beau_interviews = scoped.uniq
    @count = @beau_interviews.count
    @beau_interviews_excel = @beau_interviews
    @beau_interviews = Kaminari.paginate_array(@beau_interviews).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def cnpr_list
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Fctabletinterview"
      history.save
    end

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

    if min_age_custinfo.nil?
      min_age_custinfo = Custinfo.where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @tabletinterviews = []
    is_contain = true

    scoped = Fctabletinterviewrx.where(ch_cd: @ch_array)
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.faceno LIKE ?", "%#{@select_area}%") if !@select_area.blank? && @select_area != "all"
    end

    temp_end_date = @end_date.to_date+1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fctabletinterviewrx.uptdate) >= ? AND to_date(fctabletinterviewrx.uptdate) < ?", @start_date.to_date, temp_end_date)
    end

    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(mmode: @select_mode) if !@select_mode.blank? && @select_mode.downcase != "all"
    scoped = scoped.where.not(before_overlap: nil).where.not(before_overlap: "null") if !@before_overlap.blank? && @before_overlap == "T"
    scoped = scoped.where.not(after_overlap: nil).where.not(after_overlap: "null") if !@after_overlap.blank? && @after_overlap == "T"

    if @select_filter == []
      @excel_name = ["이름","시리얼","채널","진단 날짜","진단횟수","생년월일","A1","A2","A3","B1","B2","B3","B4","B5","B6","C1","D1","D2","D3","D4","D5","D6",
      "피부타입","진단으로 나온 솔루션 1(최근)","진단으로 나온 솔루션 2(최근)","진단으로 나온 솔루션 1","진단으로 나온 솔루션 2","최종으로 선택된 솔루션 1","최종으로 선택된 솔루션 2","추천 프로그램","최종 선택 프로그램",
      "턴오버 점수","각질 측정","스트레스 지수","맞춤제품 Step1","맞춤제품 Step2","맞춤제품 Step3","구매제품 Step1","구매제품 Step2","구매제품 Step3","추천 중복샷", "변경 중복샷",
      "트러블 점수","색소침착 점수","주름 점수","탄력 점수", "건조 점수"]
    else
      @excel_name = ["이름","시리얼","채널","진단 날짜","진단횟수","생년월일"]
      @select_filter.each do |filter|
        if filter.include?("skin_type")
          filter = "피부타입"
        elsif filter.include?("before_solution_1_new")
          filter = "진단으로 나온 솔루션 1(최근)"
        elsif filter.include?("before_solution_2_new")
          filter = "진단으로 나온 솔루션 2(최근)"
        elsif filter.include?("before_solution_1")
          filter = "진단으로 나온 솔루션 1"
        elsif filter.include?("before_solution_2")
          filter = "진단으로 나온 솔루션 2"
        elsif filter.include?("after_solution_1")
          filter = "최종으로 선택된 솔루션 1"
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

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil?
      scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sex}%") if @select_sex != "all"
      scoped = scoped.joins(:custinfo).where("custinfo.shop_cd LIKE ?",  "%#{@shop_cd}%") if !@shop_cd.blank?
      if !@start_age.blank? && !@end_age.blank?
        start_birthyy = Time.current.year.to_i - @start_age.to_i
        end_birthyy = Time.current.year.to_i - @end_age.to_i
        scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
      end

      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", @start_birthyy, @end_birthyy) if !@start_birthyy.blank? && !@end_birthyy.blank?
      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthmm) >= ? AND to_number(custinfo.birthmm) < ?", @start_birthmm, @end_birthmm) if !@start_birthmm.blank? && !@end_birthmm.blank?

      scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", "%#{params[:is_agree_thirdparty_info]}%") if params.has_key?(:is_agree_thirdparty_info)
    end

    scoped = scoped.order("fctabletinterviewrx.uptdate desc")

    @tabletinterviews = scoped

    @count = @tabletinterviews.count
    @tabletinterviews_excel = @tabletinterviews
    @tabletinterviews = Kaminari.paginate_array(@tabletinterviews).page(params[:page]).per(5)

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
