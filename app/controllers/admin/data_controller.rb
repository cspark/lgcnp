class Admin::DataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @start_date = Date.today
    @end_date = Date.today
    @today = Date.today

    select_sex = params[:select_sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    name = params[:name]
    custserial = params[:custserial]
    measureno = params[:measureno]
    start_birthyy = params[:start_birthyy]
    end_birthyy = params[:end_birthyy]
    start_birthmm = params[:start_birthmm]
    end_birthmm = params[:end_birthmm]
    select_channel = params[:select_channel]
    select_mode = params[:select_mode]
    select_makeup = params[:select_makeup]
    select_area = params[:select_area]
    select_skin_type_device = params[:select_skin_type_device]
    select_skin_type_survey = params[:select_skin_type_survey]
    select_senstive = params[:select_senstive]
    select_skin_anxiety1 = params[:select_skin_anxiety1]
    select_skin_anxiety2 = params[:select_skin_anxiety2]
    @params_filter = params[:select_filter]

    @select_sex = select_sex
    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @name = name
    @custserial = custserial
    @measureno = measureno
    @start_birthyy = start_birthyy
    @end_birthyy = end_birthyy
    @start_birthmm = start_birthmm
    @end_birthmm = end_birthmm
    @select_channel = select_channel
    @select_mode = select_mode
    @select_makeup = select_makeup
    @select_area = select_area
    @select_skin_type_device = select_skin_type_device
    @select_skin_type_survey = select_skin_type_survey
    @select_senstive = select_senstive
    @select_skin_anxiety1 = select_skin_anxiety1
    @select_skin_anxiety2 = select_skin_anxiety2

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @min_birthmm = 1
    max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @max_birthyy = max_age_custinfo.birthyy
    @max_birthmm = 12

    if !@select_skin_type_device.blank? && @select_skin_type_device != "all"
      if @select_skin_type_device == "gunsung"
        @select_skin_type_device = 0
      elsif @select_skin_type_device == "jungsung"
        @select_skin_type_device = 1
      elsif @select_skin_type_device == "jisung"
        @select_skin_type_device = 2
      elsif @select_skin_type_device == "t_zone_boghab"
        @select_skin_type_device = 3
      elsif @select_skin_type_device == "u_zone_boghab"
        @select_skin_type_device = 4
      end
    end

    @fcdatas = []
    if Rails.env.production? || Rails.env.staging?
      scoped = Fcdata.all
      temp_end_date = @end_date.to_date + 1.day
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.where(measureno: @measureno) if !@measureno.blank?
      scoped = scoped.where(faceno: @select_area.to_i) if !@select_area.blank? && @select_area.downcase != "all"
      scoped = scoped.where("skintype LIKE ?", "%#{@select_skin_type_device}%") if !@select_skin_type_device.blank? && @select_skin_type_device != "all"

      if @select_filter == []
        @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일","수분 측정1","수분 측정2","수분 측정3","모공 측정1","모공 측정2","모공 측정7","모공 측정8","모공 측정avr","주름 측정3", "주름 측정4", "주름 측정6", "주름 측정avr",
        "탄력 측정7", "탄력 측정8", "탄력 측정avr", "탄력 각도7", "탄력 각도8", "피지 측정1", "피지 측정2", "피지 측정7", "피지 측정8", "피지 측정avr", "포피린 측정1", "포피린 측정2", "포피린 측정7", "포피린 측정8", "포피린 측정avr",
        "포피린 비 측정1", "포피린 비 측정2", "포피린 비 측정7", "포피린 비 측정8", "포피린 비 측정avr", "편광 색소침착 측정1", "편광 색소침착 측정2", "편광 색소침착 측정3", "편광 색소침착 측정4", "편광 색소침착 측정5", "편광 색소침착 측정6", "편광 색소침착 측정7", "편광 색소침착 측정8", "편광 색소침착 측정avr",
        "UV광 색소침착 측정1", "UV광 색소침착 측정2", "UV광 색소침착 측정3","UV광 색소침착 측정4","UV광 색소침착 측정5","UV광 색소침착 측정6","UV광 색소침착 측정7","UV광 색소침착 측정8","UV광 색소침착 측정avr","피부톤 측정1","피부톤 측정2","피부톤 측정4","피부톤 측정6","피부톤 측정7","피부톤 측정8","피부톤 측정avr",
        "피부톤 Red 측정1","피부톤 Red 측정2","피부톤 Red 측정4","피부톤 Red 측정6","피부톤 Red 측정7","피부톤 Red 측정8","피부톤 Red 측정avr","피부톤 Green 측정1","피부톤 Green 측정2","피부톤 Green 측정4","피부톤 Green 측정6","피부톤 Green 측정7","피부톤 Green 측정8","피부톤 Green 측정avr",
        "피부톤 Blue 측정1","피부톤 Blue 측정2","피부톤 Blue 측정4","피부톤 Blue 측정6","피부톤 Blue 측정7","피부톤 Blue 측정8","피부톤 Blue 측정avr","피부톤 칼라 타입","선 민감도","동안각도 점수 우측","동안각도 점수 좌측","피부타입"]
      else
        # scoped = scoped.select("custserial,faceno,measuredate,measureno,uptdate," +@params_filter)
        @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일"]
        @select_filter.each do |filter|
          @excel_name << filter
        end
      end

      # scoped = scoped.where(skintype: @select_skin_type_survey) if !@select_skin_type_survey.blank? && @select_skin_type_survey != "all"

      scoped = scoped.order("uptdate desc")

      scoped.each do |fcdata|
        custinfo = Custinfo.where(custserial: fcdata.custserial).first
        is_contain = true

        # 필드 추가
        # if !@select_mode.blank?
        #   if @select_mode.downcase != "all"
        #     if @select_mode == "quick"
        #       scoped = scoped.where(is_quick_mode: "T")
        #     end
        #   end
        # end

        # if !@select_makeup.blank?
        #   if @select_makeup.downcase != "all"
        #     scoped = scoped.where(is_make_up: @select_makeup)
        #   end
        # end

        if !@name.blank?
          if !custinfo.custname.include? @name
            is_contain = false
          end
        end

        if @select_sex != "all"
          if custinfo.sex != @select_sex
            is_contain = false
          end
        end

        if !@start_age.blank? && !@end_age.blank?
          temp_age = Time.current.year.to_i - custinfo.birthyy.to_i
          if temp_age < @start_age.to_i || temp_age > @end_age.to_i
            is_contain = false
          end
        end

        if !@start_birthyy.blank? && !@end_birthyy.blank?
          if custinfo.birthyy.to_i < @start_birthyy.to_i || custinfo.birthyy.to_i > @end_birthyy.to_i
            is_contain = false
          end
        end

        if !@start_birthmm.blank? && !@end_birthmm.blank?
          if custinfo.birthmm.to_i < @start_birthmm.to_i || custinfo.birthmm.to_i > @end_birthmm.to_i
            is_contain = false
          end
        end

        if @select_channel != "all"
          if custinfo.ch_cd != @select_channel
            is_contain = false
          end
        end

        if is_contain == true
          @fcdatas << fcdata
        end
      end

      @fcdatas_excel = @fcdatas
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
    else
      if @select_filter == []
        @fcdatas = Fcdata.all
        @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일","수분 측정1","수분 측정2","수분 측정3","모공 측정1","모공 측정2","모공 측정7","모공 측정8","모공 측정avr","주름 측정3", "주름 측정4", "주름 측정6", "주름 측정avr",
        "탄력 측정7", "탄력 측정8", "탄력 측정avr", "탄력 각도7", "탄력 각도8", "피지 측정1", "피지 측정2", "피지 측정7", "피지 측정8", "피지 측정avr", "포피린 측정1", "포피린 측정2", "포피린 측정7", "포피린 측정8", "포피린 측정avr",
        "포피린 비 측정1", "포피린 비 측정2", "포피린 비 측정7", "포피린 비 측정8", "포피린 비 측정avr", "편광 색소침착 측정1", "편광 색소침착 측정2", "편광 색소침착 측정3", "편광 색소침착 측정4", "편광 색소침착 측정5", "편광 색소침착 측정6", "편광 색소침착 측정7", "편광 색소침착 측정8", "편광 색소침착 측정avr",
        "UV광 색소침착 측정1", "UV광 색소침착 측정2", "UV광 색소침착 측정3","UV광 색소침착 측정4","UV광 색소침착 측정5","UV광 색소침착 측정6","UV광 색소침착 측정7","UV광 색소침착 측정8","UV광 색소침착 측정avr","피부톤 측정1","피부톤 측정2","피부톤 측정4","피부톤 측정6","피부톤 측정7","피부톤 측정8","피부톤 측정avr",
        "피부톤 Red 측정1","피부톤 Red 측정2","피부톤 Red 측정4","피부톤 Red 측정6","피부톤 Red 측정7","피부톤 Red 측정8","피부톤 Red 측정avr","피부톤 Green 측정1","피부톤 Green 측정2","피부톤 Green 측정4","피부톤 Green 측정6","피부톤 Green 측정7","피부톤 Green 측정8","피부톤 Green 측정avr",
        "피부톤 Blue 측정1","피부톤 Blue 측정2","피부톤 Blue 측정4","피부톤 Blue 측정6","피부톤 Blue 측정7","피부톤 Blue 측정8","피부톤 Blue 측정avr","피부톤 칼라 타입","선 민감도","동안각도 점수 우측","동안각도 점수 좌측","피부타입"]
      else
        @fcdatas = Fcdata.all.select("custserial,faceno,measuredate,measureno,uptdate," +@params_filter)
        @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일"]
        @select_filter.each do |filter|
          @excel_name << filter
        end
      end
      @fcdatas_excel = @fcdatas
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @fcdata = Fcdata.where(custserial: params[:userId]).where(measureno: params[:measureno]).first
  end
end
