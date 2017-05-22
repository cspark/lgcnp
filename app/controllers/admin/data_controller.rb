class Admin::DataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @start_date = "2017-01-25"
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
    @select_mode = select_mode
    @select_makeup = select_makeup
    @select_area = select_area
    @select_senstive = select_senstive
    @select_skin_anxiety1 = select_skin_anxiety1
    @select_skin_anxiety2 = select_skin_anxiety2
    @select_skin_type_device = params[:select_skin_type_device]
    @select_skin_type_survey = params[:select_skin_type_survey]

    @is_agree_thirdparty_info = params[:is_agree_thirdparty_info] if !params[:is_agree_thirdparty_info].blank?
    @is_init = true
    if params[:select_sex].present?
      @is_init = false
    end

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    @skin_type_device_array = []
      if !select_skin_type_device.blank?
      select_skin_type_device.split(",").each do |skin_type|
        @skin_type_device_array.push(skin_type)
      end
    end

    @skin_type_survey_array = []
    Rails.logger.info "@select_senstive!!!!"
    Rails.logger.info @select_senstive
    if !select_skin_type_survey.blank?
      if @select_senstive == "all"
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type)
          @skin_type_survey_array.push(skin_type+"_senstive")
        end
      elsif @select_senstive == "yes"
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type+"_senstive")
        end
      else
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type)
        end
      end
    end

    @select_skin_anxiety1_array = []
    if !select_skin_anxiety1.blank?
      select_skin_anxiety1.split(",").each do |anxiety|
        @select_skin_anxiety1_array.push(anxiety)
      end
    end

    @select_skin_anxiety2_array = []
    if !select_skin_anxiety2.blank?
      select_skin_anxiety2.split(",").each do |anxiety|
        @select_skin_anxiety2_array.push(anxiety)
      end
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


    @select_skin_type_device_final = []
    if !@skin_type_device_array.blank?
      if @skin_type_device_array.include?("gunsung")
        @select_skin_type_device_final.push(1)
      end
      if @skin_type_device_array.include?("jungsung")
        @select_skin_type_device_final.push(2)
      end
      if @skin_type_device_array.include?("jisung")
        @select_skin_type_device_final.push(3)
      end
      if @skin_type_device_array.include?("t_zone_boghab")
        @select_skin_type_device_final.push(4)
        @select_skin_type_device_final.push(6)
        @select_skin_type_device_final.push(8)
      end
      if @skin_type_device_array.include?("u_zone_boghab")
        @select_skin_type_device_final.push(5)
        @select_skin_type_device_final.push(7)
        @select_skin_type_device_final.push(9)
      end
    end

    if @select_skin_anxiety1_array.blank? || @skin_type_survey_array.blank?
      serial_array = Fctabletinterview.where(before_solution_1: ["!!"]).pluck(:custserial).uniq
    else
      serial_array = Fctabletinterview.where(before_solution_1: @select_skin_anxiety1_array).where(skin_type: @skin_type_survey_array).where.not(before_solution_1: nil).where.not(before_solution_2: nil).pluck(:custserial).uniq
    end

    if @select_skin_anxiety2_array.blank? || @skin_type_survey_array.blank?
      serial_array2 = Fctabletinterview.where(before_solution_2: ["!!"]).pluck(:custserial).uniq
    else
      serial_array2 = Fctabletinterview.where(before_solution_2: @select_skin_anxiety2_array).where(skin_type: @skin_type_survey_array).where.not(before_solution_1: nil).where.not(before_solution_2: nil).pluck(:custserial).uniq
    end
    serial_array = serial_array & serial_array2

    Rails.logger.info "serial_array.count!!!"
    Rails.logger.info serial_array.count

    @fcdatas = []
    @fcdatas_final = []
    scoped = Fcdata.where(ch_cd: @ch_array).where(custserial: serial_array)
    Rails.logger.info "serial_array Fcdata scoped count!!!"
    Rails.logger.info scoped.count

    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(measureno: @measureno) if !@measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"
    Rails.logger.info "Fcdata scoped count!!!"
    Rails.logger.info scoped.count
    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
    end
    Rails.logger.info "select_skin_type_device_final Fcdata scoped count!!!"
    Rails.logger.info scoped.count

    if @select_filter == []
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일","수분 측정1","수분 측정2","수분 측정3","모공 측정1","모공 측정2","모공 측정7","모공 측정8","모공 측정avr","주름 측정3", "주름 측정4", "주름 측정6", "주름 측정avr",
      "탄력 측정7", "탄력 측정8", "탄력 측정avr", "탄력 각도7", "탄력 각도8", "피지 측정1", "피지 측정2", "피지 측정7", "피지 측정8", "피지 측정avr", "포피린 측정1", "포피린 측정2", "포피린 측정7", "포피린 측정8", "포피린 측정avr",
      "포피린 비 측정1", "포피린 비 측정2", "포피린 비 측정7", "포피린 비 측정8", "포피린 비 측정avr", "편광 색소침착 측정1", "편광 색소침착 측정2", "편광 색소침착 측정3", "편광 색소침착 측정4", "편광 색소침착 측정5", "편광 색소침착 측정6", "편광 색소침착 측정7", "편광 색소침착 측정8", "편광 색소침착 측정avr",
      "UV광 색소침착 측정1", "UV광 색소침착 측정2", "UV광 색소침착 측정3","UV광 색소침착 측정4","UV광 색소침착 측정5","UV광 색소침착 측정6","UV광 색소침착 측정7","UV광 색소침착 측정8","UV광 색소침착 측정avr","피부톤 측정1","피부톤 측정2","피부톤 측정4","피부톤 측정6","피부톤 측정7","피부톤 측정8","피부톤 측정avr",
      "피부톤 Red 측정1","피부톤 Red 측정2","피부톤 Red 측정4","피부톤 Red 측정6","피부톤 Red 측정7","피부톤 Red 측정8","피부톤 Red 측정avr","피부톤 Green 측정1","피부톤 Green 측정2","피부톤 Green 측정4","피부톤 Green 측정6","피부톤 Green 측정7","피부톤 Green 측정8","피부톤 Green 측정avr",
      "피부톤 Blue 측정1","피부톤 Blue 측정2","피부톤 Blue 측정4","피부톤 Blue 측정6","피부톤 Blue 측정7","피부톤 Blue 측정8","피부톤 Blue 측정avr","Lab L","Lab a","Lab b","피부타입 기준 값 (T 존)","피부타입 기준 값 (U 존)","피부톤 칼라 타입","선 민감도","동안각도 점수 우측","동안각도 점수 좌측","피부타입"]
    else
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정1"
        elsif filter.include?("mo_7")
          filter = "수분 측정7"
        elsif filter.include?("mo_8")
          filter = "수분 측정7"
        elsif filter.include?("pr_1")
          filter = "모공 측정1"
        elsif filter.include?("pr_2")
          filter = "모공 측정2"
        elsif filter.include?("pr_7")
          filter = "모공 측정7"
        elsif filter.include?("pr_8")
          filter = "모공 측정8"
        elsif filter.include?("pr_avr")
          filter = "모공 측정avr"
        elsif filter.include?("wr_3")
          filter = "주름 측정3"
        elsif filter.include?("wr_4")
          filter = "주름 측정4"
        elsif filter.include?("wr_6")
          filter = "주름 측정6"
        elsif filter.include?("wr_avr")
          filter = "수분 측정avr"
        elsif filter.include?("el_7")
          filter = "탄력 측정7"
        elsif filter.include?("el_8")
          filter = "탄력 측정8"
        elsif filter.include?("el_avr")
          filter = "탄력 측정avr"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도7"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도8"
        elsif filter.include?("sb_1")
          filter = "피지 측정1"
        elsif filter.include?("sb_2")
          filter = "피지 측정2"
        elsif filter.include?("sb_7")
          filter = "피지 측정7"
        elsif filter.include?("sb_8")
          filter = "피지 측정8"
        elsif filter.include?("sb_avr")
          filter = "피지 측정avr"
        elsif filter.include?("pp_1")
          filter = "포피린 측정1"
        elsif filter.include?("pp_2")
          filter = "포피린 측정2"
        elsif filter.include?("pp_7")
          filter = "포피린 측정7"
        elsif filter.include?("pp_8")
          filter = "포피린 측정8"
        elsif filter.include?("pp_avr")
          filter = "포피린 측정avr"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 측정1"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 측정2"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 측정7"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 측정8"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 측정avr"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정1"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정2"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정3"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정4"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정5"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정6"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정7"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정8"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정avr"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정1"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정2"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정3"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정4"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정5"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정6"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정7"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정8"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정avr"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정1"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정2"
        elsif filter.include?("sk_c_3")
          filter = "피부톤 측정3"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정4"
        elsif filter.include?("sk_c_5")
          filter = "피부톤 측정5"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정6"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정7"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정8"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정avr"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red1"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red2"
        elsif filter.include?("sk_r_3")
          filter = "피부톤 Red3"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red4"
        elsif filter.include?("sk_r_5")
          filter = "피부톤 Red5"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red6"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red7"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red8"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red_avr"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green1"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green2"
        elsif filter.include?("sk_g_3")
          filter = "피부톤 Green3"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green4"
        elsif filter.include?("sk_g_5")
          filter = "피부톤 Green5"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green6"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green7"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green8"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green_avr"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue1"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue2"
        elsif filter.include?("sk_b_3")
          filter = "피부톤 Blue3"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue4"
        elsif filter.include?("sk_b_5")
          filter = "피부톤 Blue5"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue6"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue7"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue8"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue_avr"
        elsif filter.include?("lab_l")
          filter = "Lab L"
        elsif filter.include?("lab_a")
          filter = "Lab a"
        elsif filter.include?("lab_b")
          filter = "Lab b"
        elsif filter.include?("e_sebum_t")
          filter = "피부타입 기준 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피부타입 기준 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤 칼라 타입"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("skintype")
          filter = "피부타입"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end

    scoped = scoped.order("measuredate desc")
    Rails.logger.info "fcdata scoped.count!!!!"
    Rails.logger.info scoped.count

    scoped.each do |fcdata|
      custinfo = Custinfo.where(custserial: fcdata.custserial).first
      is_contain = true

      if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info] != "T,F"
        if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("T")
          if custinfo.is_agree_thirdparty_info == "F"
            is_contain = false
          end
        end
        if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("F")
          if custinfo.is_agree_thirdparty_info == "T"
            is_contain = false
          end
        end
      end

      if !params.has_key?(:is_agree_thirdparty_info) || params[:is_agree_thirdparty_info] == ""
        is_contain = false
      end

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

      if is_contain == true
        @fcdatas << fcdata
      end
    end

    @fcdatas.each do |fcdata|
      fctabletinterview = Fctabletinterview.where.not(skin_type: nil).where(custserial: fcdata.custserial.to_i).where(fcdata_id: fcdata.measureno.to_i).first
      is_contain = true

      if !fctabletinterview.nil?
        if !@select_makeup.blank? && @select_makeup != "all"
          if fctabletinterview.a_1 != @select_makeup.to_i
            is_contain = false
          end
        end

        Rails.logger.info @select_mode if !@select_mode.blank?

        if !@select_mode.blank? && @select_mode != "all"
          if fctabletinterview.is_quick_mode != @select_mode
            is_contain = false
          end
        end
      end

      if is_contain == true
        @fcdatas_final << fcdata
      end
    end

    @count = @fcdatas_final.count
    @fcdatas_excel = @fcdatas_final
    @fcdatas = Kaminari.paginate_array(@fcdatas_final).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @fcdata = Fcdata.where(custserial: params[:userId]).where(measureno: params[:measureno]).first
  end

  def beau_list
    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @start_date = "2017-01-25"
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
    @select_mode = select_mode
    @select_makeup = select_makeup
    @select_area = select_area
    @select_senstive = select_senstive
    @select_skin_anxiety1 = select_skin_anxiety1
    @select_skin_anxiety2 = select_skin_anxiety2
    @select_skin_type_device = params[:select_skin_type_device]
    @select_skin_type_survey = params[:select_skin_type_survey]

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    @skin_type_device_array = []
      if !select_skin_type_device.blank?
      select_skin_type_device.split(",").each do |skin_type|
        @skin_type_device_array.push(skin_type)
      end
    end

    @skin_type_survey_array = []
    if !select_skin_type_survey.blank?
      select_skin_type_survey.split(",").each do |skin_type|
        @skin_type_survey_array.push(skin_type.to_i)
      end
    end

    @select_skin_anxiety1_array = []
    if !select_skin_anxiety1.blank?
      select_skin_anxiety1.split(",").each do |anxiety|
        @select_skin_anxiety1_array.push(anxiety.to_i)
      end
    end

    @select_skin_anxiety2_array = []
    if !select_skin_anxiety2.blank?
      select_skin_anxiety2.split(",").each do |anxiety|
        @select_skin_anxiety2_array.push(anxiety.to_i)
      end
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

    @select_skin_type_device_final = []
    if !@skin_type_device_array.blank?
      if @skin_type_device_array.include?("gunsung")
        @select_skin_type_device_final.push(1)
      end
      if @skin_type_device_array.include?("jungsung")
        @select_skin_type_device_final.push(2)
      end
      if @skin_type_device_array.include?("jisung")
        @select_skin_type_device_final.push(3)
      end
      if @skin_type_device_array.include?("t_zone_boghab")
        @select_skin_type_device_final.push(4)
        @select_skin_type_device_final.push(6)
        @select_skin_type_device_final.push(8)
      end
      if @skin_type_device_array.include?("u_zone_boghab")
        @select_skin_type_device_final.push(5)
        @select_skin_type_device_final.push(7)
        @select_skin_type_device_final.push(9)
      end
    end

    @fcdatas = []
    @fcdatas_final = []
    serial_array = []
    if !@select_senstive.blank? && @select_senstive != "all"
      serial_array = Fcinterview.where(interview_2: @select_senstive).pluck(:custserial).uniq
    end

    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where(custserial: serial_array) if @select_senstive != "all"
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(measureno: @measureno) if !@measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"
    scoped = scoped.where(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode == "F"
    scoped = scoped.where(m_skintype: [1,2,3]) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode == "T"


    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
    end

    if @skin_type_survey_array.blank?
      scoped = scoped.where(m_skintype: [100])
    else
      scoped = scoped.where(m_skintype: @skin_type_survey_array)
    end

    if @select_skin_anxiety1_array.blank?
      scoped = scoped.where(worry_skin_1: [100])
    else
      scoped = scoped.where(worry_skin_1: @select_skin_anxiety1_array)
    end

    if @select_skin_anxiety2_array.blank?
      scoped = scoped.where(worry_skin_2: [100])
    else
      scoped = scoped.where(worry_skin_2: @select_skin_anxiety2_array)
    end

    if @select_filter == []
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일","수분 측정1","수분 측정2","수분 측정3","모공 측정1","모공 측정2","모공 측정7","모공 측정8","모공 측정avr","주름 측정3", "주름 측정4", "주름 측정6", "주름 측정avr",
      "탄력 측정7", "탄력 측정8", "탄력 측정avr", "탄력 각도7", "탄력 각도8", "피지 측정1", "피지 측정2", "피지 측정7", "피지 측정8", "피지 측정avr", "포피린 측정1", "포피린 측정2", "포피린 측정7", "포피린 측정8", "포피린 측정avr",
      "포피린 비 측정1", "포피린 비 측정2", "포피린 비 측정7", "포피린 비 측정8", "포피린 비 측정avr", "편광 색소침착 측정1", "편광 색소침착 측정2", "편광 색소침착 측정3", "편광 색소침착 측정4", "편광 색소침착 측정5", "편광 색소침착 측정6", "편광 색소침착 측정7", "편광 색소침착 측정8", "편광 색소침착 측정avr",
      "UV광 색소침착 측정1", "UV광 색소침착 측정2", "UV광 색소침착 측정3","UV광 색소침착 측정4","UV광 색소침착 측정5","UV광 색소침착 측정6","UV광 색소침착 측정7","UV광 색소침착 측정8","UV광 색소침착 측정avr","피부톤 측정1","피부톤 측정2","피부톤 측정4","피부톤 측정6","피부톤 측정7","피부톤 측정8","피부톤 측정avr",
      "피부톤 Red 측정1","피부톤 Red 측정2","피부톤 Red 측정4","피부톤 Red 측정6","피부톤 Red 측정7","피부톤 Red 측정8","피부톤 Red 측정avr","피부톤 Green 측정1","피부톤 Green 측정2","피부톤 Green 측정4","피부톤 Green 측정6","피부톤 Green 측정7","피부톤 Green 측정8","피부톤 Green 측정avr",
      "피부톤 Blue 측정1","피부톤 Blue 측정2","피부톤 Blue 측정4","피부톤 Blue 측정6","피부톤 Blue 측정7","피부톤 Blue 측정8","피부톤 Blue 측정avr","Lab L","Lab a","Lab b","피부타입 기준 값 (T 존)","피부타입 기준 값 (U 존)","피부톤 칼라 타입","선 민감도","동안각도 점수 우측","동안각도 점수 좌측","피부타입"]
    else
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정1"
        elsif filter.include?("mo_7")
          filter = "수분 측정7"
        elsif filter.include?("mo_8")
          filter = "수분 측정7"
        elsif filter.include?("pr_1")
          filter = "모공 측정1"
        elsif filter.include?("pr_2")
          filter = "모공 측정2"
        elsif filter.include?("pr_7")
          filter = "모공 측정7"
        elsif filter.include?("pr_8")
          filter = "모공 측정8"
        elsif filter.include?("pr_avr")
          filter = "모공 측정avr"
        elsif filter.include?("wr_3")
          filter = "주름 측정3"
        elsif filter.include?("wr_4")
          filter = "주름 측정4"
        elsif filter.include?("wr_6")
          filter = "주름 측정6"
        elsif filter.include?("wr_avr")
          filter = "수분 측정avr"
        elsif filter.include?("el_7")
          filter = "탄력 측정7"
        elsif filter.include?("el_8")
          filter = "탄력 측정8"
        elsif filter.include?("el_avr")
          filter = "탄력 측정avr"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도7"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도8"
        elsif filter.include?("sb_1")
          filter = "피지 측정1"
        elsif filter.include?("sb_2")
          filter = "피지 측정2"
        elsif filter.include?("sb_7")
          filter = "피지 측정7"
        elsif filter.include?("sb_8")
          filter = "피지 측정8"
        elsif filter.include?("sb_avr")
          filter = "피지 측정avr"
        elsif filter.include?("pp_1")
          filter = "포피린 측정1"
        elsif filter.include?("pp_2")
          filter = "포피린 측정2"
        elsif filter.include?("pp_7")
          filter = "포피린 측정7"
        elsif filter.include?("pp_8")
          filter = "포피린 측정8"
        elsif filter.include?("pp_avr")
          filter = "포피린 측정avr"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 측정1"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 측정2"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 측정7"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 측정8"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 측정avr"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정1"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정2"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정3"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정4"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정5"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정6"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정7"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정8"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정avr"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정1"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정2"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정3"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정4"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정5"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정6"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정7"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정8"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정avr"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정1"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정2"
        elsif filter.include?("sk_c_3")
          filter = "피부톤 측정3"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정4"
        elsif filter.include?("sk_c_5")
          filter = "피부톤 측정5"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정6"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정7"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정8"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정avr"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red1"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red2"
        elsif filter.include?("sk_r_3")
          filter = "피부톤 Red3"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red4"
        elsif filter.include?("sk_r_5")
          filter = "피부톤 Red5"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red6"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red7"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red8"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red_avr"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green1"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green2"
        elsif filter.include?("sk_g_3")
          filter = "피부톤 Green3"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green4"
        elsif filter.include?("sk_g_5")
          filter = "피부톤 Green5"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green6"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green7"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green8"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green_avr"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue1"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue2"
        elsif filter.include?("sk_b_3")
          filter = "피부톤 Blue3"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue4"
        elsif filter.include?("sk_b_5")
          filter = "피부톤 Blue5"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue6"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue7"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue8"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue_avr"
        elsif filter.include?("lab_l")
          filter = "Lab L"
        elsif filter.include?("lab_a")
          filter = "Lab a"
        elsif filter.include?("lab_b")
          filter = "Lab b"
        elsif filter.include?("e_sebum_t")
          filter = "피부타입 기준 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피부타입 기준 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤 칼라 타입"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("skintype")
          filter = "피부타입"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end

    scoped = scoped.order("measuredate desc")
    Rails.logger.info scoped.count

    scoped.each do |fcdata|
      custinfo = Custinfo.where(custserial: fcdata.custserial).first
      is_contain = true

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

      if is_contain == true
        @fcdatas << fcdata
      end
    end

    @count = @fcdatas.count
    @fcdatas_excel = @fcdatas
    @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def cnpr_list
    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @start_date = "2017-01-25"
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
    select_area = params[:select_area]
    select_skin_type_device = params[:select_skin_type_device]
    select_skin_type_survey = params[:select_skin_type_survey]
    select_senstive = params[:select_senstive]
    select_skin_anxiety1 = params[:select_skin_anxiety1]
    select_skin_anxiety2 = params[:select_skin_anxiety2]
    overlap = params[:overlap]
    select_mode = params[:select_mode]
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
    @select_area = select_area
    @select_senstive = select_senstive
    @select_skin_anxiety1 = select_skin_anxiety1
    @select_skin_anxiety2 = select_skin_anxiety2
    @select_skin_type_device = params[:select_skin_type_device]
    @select_skin_type_survey = params[:select_skin_type_survey]
    @overlap = overlap if !overlap.blank?
    @select_mode = select_mode

    @is_init = true
    if params[:select_sex].present?
      @is_init = false
    end

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    @skin_type_device_array = []
      if !select_skin_type_device.blank?
      select_skin_type_device.split(",").each do |skin_type|
        @skin_type_device_array.push(skin_type)
      end
    end

    @skin_type_survey_array = []
    Rails.logger.info "@select_senstive!!!!"
    Rails.logger.info @select_senstive
    if !select_skin_type_survey.blank?
      if @select_senstive == "all"
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type)
          @skin_type_survey_array.push(skin_type+"_senstive")
        end
      elsif @select_senstive == "yes"
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type+"_senstive")
        end
      else
        select_skin_type_survey.split(",").each do |skin_type|
          @skin_type_survey_array.push(skin_type)
        end
      end
    end

    @select_skin_anxiety1_array = []
    if !select_skin_anxiety1.blank?
      select_skin_anxiety1.split(",").each do |anxiety|
        @select_skin_anxiety1_array.push(anxiety)
      end
    end


    @select_skin_anxiety2_array = []
    if !select_skin_anxiety2.blank?
      select_skin_anxiety2.split(",").each do |anxiety|
        @select_skin_anxiety2_array.push(anxiety)
      end
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "CNPR").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "CNPR").order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i + 1
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i + 1
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @select_skin_type_device_final = []
    if !@skin_type_device_array.blank?
      if @skin_type_device_array.include?("gunsung")
        @select_skin_type_device_final.push(1)
      end
      if @skin_type_device_array.include?("jungsung")
        @select_skin_type_device_final.push(2)
      end
      if @skin_type_device_array.include?("jisung")
        @select_skin_type_device_final.push(3)
      end
      if @skin_type_device_array.include?("t_zone_boghab")
        @select_skin_type_device_final.push(4)
        @select_skin_type_device_final.push(6)
        @select_skin_type_device_final.push(8)
      end
      if @skin_type_device_array.include?("u_zone_boghab")
        @select_skin_type_device_final.push(5)
        @select_skin_type_device_final.push(7)
        @select_skin_type_device_final.push(9)
      end
    end
    Rails.logger.info "@select_skin_type_device_final!!"
    Rails.logger.info @select_skin_type_device_final
    Rails.logger.info @ch_array
    Rails.logger.info @select_skin_anxiety1_array
    Rails.logger.info @select_skin_anxiety2_array
    Rails.logger.info @skin_type_survey_array

    if @select_skin_anxiety1_array.blank? || @skin_type_survey_array.blank?
      serial_array = Fctabletinterviewrx.where(before_solution_1: ["!!"]).pluck(:custserial).uniq
    else
      serial_array = Fctabletinterviewrx.where(before_solution_1: @select_skin_anxiety1_array).where(skin_type: @skin_type_survey_array).pluck(:custserial).uniq
    end

    if @select_skin_anxiety2_array.blank? || @skin_type_survey_array.blank?
      serial_array2 = Fctabletinterviewrx.where(before_solution_2: ["!!"]).pluck(:custserial).uniq
    else
      serial_array2 = Fctabletinterviewrx.where(before_solution_2: @select_skin_anxiety2_array).where(skin_type: @skin_type_survey_array).pluck(:custserial).uniq
    end
    serial_array = serial_array & serial_array2

    @fcdatas = []
    @fcdatas_final = []

    Rails.logger.info "serial_array!!!"
    Rails.logger.info serial_array
    Rails.logger.info serial_array.count

    scoped = Fcdata.where(ch_cd: @ch_array).where(custserial: serial_array)
    Rails.logger.info "init scoped.count!!!"
    Rails.logger.info scoped.count
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(measureno: @measureno) if !@measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"
    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
    end

    if @select_filter == []
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일","수분 측정1","수분 측정2","수분 측정3","모공 측정1","모공 측정2","모공 측정7","모공 측정8","모공 측정avr","주름 측정3", "주름 측정4", "주름 측정6", "주름 측정avr",
      "탄력 측정7", "탄력 측정8", "탄력 측정avr", "탄력 각도7", "탄력 각도8", "피지 측정1", "피지 측정2", "피지 측정7", "피지 측정8", "피지 측정avr", "포피린 측정1", "포피린 측정2", "포피린 측정7", "포피린 측정8", "포피린 측정avr",
      "포피린 비 측정1", "포피린 비 측정2", "포피린 비 측정7", "포피린 비 측정8", "포피린 비 측정avr", "편광 색소침착 측정1", "편광 색소침착 측정2", "편광 색소침착 측정3", "편광 색소침착 측정4", "편광 색소침착 측정5", "편광 색소침착 측정6", "편광 색소침착 측정7", "편광 색소침착 측정8", "편광 색소침착 측정avr",
      "UV광 색소침착 측정1", "UV광 색소침착 측정2", "UV광 색소침착 측정3","UV광 색소침착 측정4","UV광 색소침착 측정5","UV광 색소침착 측정6","UV광 색소침착 측정7","UV광 색소침착 측정8","UV광 색소침착 측정avr","피부톤 측정1","피부톤 측정2","피부톤 측정4","피부톤 측정6","피부톤 측정7","피부톤 측정8","피부톤 측정avr",
      "피부톤 Red 측정1","피부톤 Red 측정2","피부톤 Red 측정4","피부톤 Red 측정6","피부톤 Red 측정7","피부톤 Red 측정8","피부톤 Red 측정avr","피부톤 Green 측정1","피부톤 Green 측정2","피부톤 Green 측정4","피부톤 Green 측정6","피부톤 Green 측정7","피부톤 Green 측정8","피부톤 Green 측정avr",
      "피부톤 Blue 측정1","피부톤 Blue 측정2","피부톤 Blue 측정4","피부톤 Blue 측정6","피부톤 Blue 측정7","피부톤 Blue 측정8","피부톤 Blue 측정avr","Lab L","Lab a","Lab b","피부타입 기준 값 (T 존)","피부타입 기준 값 (U 존)","피부톤 칼라 타입","선 민감도","동안각도 점수 우측","동안각도 점수 좌측","피부타입"]
    else
      @excel_name = ["이름","분석 횟수","채널구분","전면/좌/우측면","분석 일","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정1"
        elsif filter.include?("mo_7")
          filter = "수분 측정7"
        elsif filter.include?("mo_8")
          filter = "수분 측정7"
        elsif filter.include?("pr_1")
          filter = "모공 측정1"
        elsif filter.include?("pr_2")
          filter = "모공 측정2"
        elsif filter.include?("pr_7")
          filter = "모공 측정7"
        elsif filter.include?("pr_8")
          filter = "모공 측정8"
        elsif filter.include?("pr_avr")
          filter = "모공 측정avr"
        elsif filter.include?("wr_3")
          filter = "주름 측정3"
        elsif filter.include?("wr_4")
          filter = "주름 측정4"
        elsif filter.include?("wr_6")
          filter = "주름 측정6"
        elsif filter.include?("wr_avr")
          filter = "수분 측정avr"
        elsif filter.include?("el_7")
          filter = "탄력 측정7"
        elsif filter.include?("el_8")
          filter = "탄력 측정8"
        elsif filter.include?("el_avr")
          filter = "탄력 측정avr"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도7"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도8"
        elsif filter.include?("sb_1")
          filter = "피지 측정1"
        elsif filter.include?("sb_2")
          filter = "피지 측정2"
        elsif filter.include?("sb_7")
          filter = "피지 측정7"
        elsif filter.include?("sb_8")
          filter = "피지 측정8"
        elsif filter.include?("sb_avr")
          filter = "피지 측정avr"
        elsif filter.include?("pp_1")
          filter = "포피린 측정1"
        elsif filter.include?("pp_2")
          filter = "포피린 측정2"
        elsif filter.include?("pp_7")
          filter = "포피린 측정7"
        elsif filter.include?("pp_8")
          filter = "포피린 측정8"
        elsif filter.include?("pp_avr")
          filter = "포피린 측정avr"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 측정1"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 측정2"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 측정7"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 측정8"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 측정avr"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정1"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정2"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정3"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정4"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정5"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정6"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정7"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정8"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정avr"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정1"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정2"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정3"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정4"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정5"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정6"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정7"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정8"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정avr"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정1"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정2"
        elsif filter.include?("sk_c_3")
          filter = "피부톤 측정3"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정4"
        elsif filter.include?("sk_c_5")
          filter = "피부톤 측정5"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정6"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정7"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정8"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정avr"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red1"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red2"
        elsif filter.include?("sk_r_3")
          filter = "피부톤 Red3"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red4"
        elsif filter.include?("sk_r_5")
          filter = "피부톤 Red5"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red6"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red7"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red8"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red_avr"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green1"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green2"
        elsif filter.include?("sk_g_3")
          filter = "피부톤 Green3"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green4"
        elsif filter.include?("sk_g_5")
          filter = "피부톤 Green5"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green6"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green7"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green8"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green_avr"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue1"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue2"
        elsif filter.include?("sk_b_3")
          filter = "피부톤 Blue3"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue4"
        elsif filter.include?("sk_b_5")
          filter = "피부톤 Blue5"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue6"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue7"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue8"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue_avr"
        elsif filter.include?("lab_l")
          filter = "Lab L"
        elsif filter.include?("lab_a")
          filter = "Lab a"
        elsif filter.include?("lab_b")
          filter = "Lab b"
        elsif filter.include?("e_sebum_t")
          filter = "피부타입 기준 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피부타입 기준 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤 칼라 타입"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("skintype")
          filter = "피부타입"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end

    scoped = scoped.order("measuredate desc")
    Rails.logger.info "scoped.count!!!"
    Rails.logger.info scoped.count

    scoped.each do |fcdata|
      custinfo = Custinfo.where(custserial: fcdata.custserial).first
      Rails.logger.info fcdata.custserial.to_i
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
        @fcdatas << fcdata
      end
    end

    @fcdatas.each do |fcdata|
      fctabletinterview = Fctabletinterviewrx.where.not(skin_type: nil).where(custserial: fcdata.custserial.to_i).where(fcdata_id: fcdata.measureno.to_i).first
      is_contain = true

      if !fctabletinterview.nil?
        # if !fctabletinterview.skin_type.nil?
        #   if @select_senstive != "all" && @select_senstive == "yes"
        #     if !fctabletinterview.skin_type.include?("senstive")
        #       is_contain = false
        #     end
        #   elsif !fctabletinterview.skin_type.nil? && @select_senstive != "all" && @select_senstive == "no"
        #     if fctabletinterview.skin_type.include?("senstive")
        #       is_contain = false
        #     end
        #   end
        # end

        if !@select_mode.blank? && @select_mode != "all"
          if fctabletinterview.mmode != @select_mode
            is_contain = false
          end
        end

        if !@overlap.blank? && @overlap == "T"
          if fctabletinterview.before_overlap.nil?
            is_contain = false
          end
          if fctabletinterview.after_overlap.nil?
            is_contain = false
          end
        end
      end

      if is_contain == true
        @fcdatas_final << fcdata
      end
    end

    @count = @fcdatas_final.count
    @fcdatas_excel = @fcdatas_final
    @fcdatas = Kaminari.paginate_array(@fcdatas_final).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end
