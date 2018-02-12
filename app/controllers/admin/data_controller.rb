class Admin::DataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
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
      history.category = "Fcdata"
      history.save
    end

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
    start_measureno = params[:start_measureno]
    end_measureno = params[:end_measureno]
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
    @start_measureno = start_measureno
    @end_measureno = end_measureno
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
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

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
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
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
    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where("shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?

    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fcdata.uptdate) >= ? AND to_date(fcdata.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where("fcdata.measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
    scoped = scoped.where("fcdata.measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"

    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
    end

    if @select_filter == []
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일","수분 측정 이마","수분 측정 우측 볼","수분 측정 좌측 볼","모공 측정 이마","모공 측정 코","모공 측정 우측 볼","모공 측정 좌측 볼","모공 측정 평균","주름 측정 우측 눈옆", "주름 측정 우측 눈밑", "주름 측정 좌측 눈옆","주름 측정 좌측 눈밑", "주름 측정 평균",
      "탄력 측정 우측 볼", "탄력 측정 좌측 볼", "탄력 측정 평균", "탄력 각도 우측 볼", "탄력 각도 좌측 볼", "피지 개수 이마", "피지 개수 코", "피지 개수 우측 볼", "피지 개수 좌측 볼", "피지 개수 평균", "포피린 개수 이마", "포피린 개수 코", "포피린 개수 우측 볼", "포피린 개수 좌측 볼", "포피린 개수 평균",
      "포피린 비 이마", "포피린 비 코", "포피린 비 우측 볼", "포피린 비 좌측 볼", "포피린 비 평균", "편광 색소침착 측정 이마", "편광 색소침착 측정 코", "편광 색소침착 측정 우측 눈옆", "편광 색소침착 측정 우측 눈밑", "편광 색소침착 측정 좌측 눈옆", "편광 색소침착 측정 좌측 눈밑", "편광 색소침착 측정 우측 볼",
      "편광 색소침착 측정 좌측 볼", "편광 색소침착 측정 평균",
      "UV광 색소침착 측정 이마", "UV광 색소침착 측정 코", "UV광 색소침착 측정 우측 눈옆","UV광 색소침착 측정 우측 눈밑","UV광 색소침착 측정 좌측 눈옆","UV광 색소침착 측정 좌측 눈밑","UV광 색소침착 측정 우측 볼",
      "UV광 색소침착 측정 좌측 볼","UV광 색소침착 측정 평균","피부톤 측정 이마","피부톤 측정 코","피부톤 측정 우측 눈밑","피부톤 측정 좌측 눈밑","피부톤 측정 우측 볼","피부톤 측정 좌측 볼","피부톤 측정 평균",
      "피부톤 Red 이마","피부톤 Red 코","피부톤 Red 우측 눈밑","피부톤 Red 좌측 눈밑","피부톤 Red 우측 볼","피부톤 Red 좌측 볼","피부톤 Red 평균","피부톤 Green 이마","피부톤 Green 코","피부톤 Green 우측 눈밑","피부톤 Green 좌측 눈밑","피부톤 Green 우측 볼","피부톤 Green 좌측 볼","피부톤 Green 평균",
      "피부톤 Blue 이마","피부톤 Blue 코","피부톤 Blue 우측 눈밑","피부톤 Blue 좌측 눈밑","피부톤 Blue 우측 볼","피부톤 Blue 좌측 볼","피부톤 Blue 평균","피부색 L 값","피부색 a 값","피부색 b 값","피지 E 값 (T 존)","피지 E 값 (U 존)","피부톤","선 민감도","피부타입(야누스 측정)","피부타입(설문 로직)","동안각도 점수 우측","동안각도 점수 좌측",
      "포피린 E 값(T존)","포피린 E 값(U존)","매장코드"]
    else
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정 이마"
        elsif filter.include?("mo_7")
          filter = "수분 측정 우측 볼"
        elsif filter.include?("mo_8")
          filter = "수분 측정 좌측 볼"
        elsif filter.include?("pr_1")
          filter = "모공 측정 이마"
        elsif filter.include?("pr_2")
          filter = "모공 측정 코"
        elsif filter.include?("pr_7")
          filter = "모공 측정 우측 볼"
        elsif filter.include?("pr_8")
          filter = "모공 측정 좌측 볼"
        elsif filter.include?("pr_avr")
          filter = "모공 측정 평균"
        elsif filter.include?("wr_3")
          filter = "주름 측정 우측 눈옆"
        elsif filter.include?("wr_4")
          filter = "주름 측정 우측 눈밑"
        elsif filter.include?("wr_5")
          filter = "주름 측정 좌측 눈옆"
        elsif filter.include?("wr_6")
          filter = "주름 측정 좌측 눈밑"
        elsif filter.include?("wr_avr")
          filter = "수분 평균"
        elsif filter.include?("el_7")
          filter = "탄력 측정 우측 볼"
        elsif filter.include?("el_8")
          filter = "탄력 측정 좌측 볼"
        elsif filter.include?("el_avr")
          filter = "탄력 측정 평균"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도 우측 볼"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도 좌측 볼"
        elsif filter.include?("sb_1")
          filter = "피지 개수 이마"
        elsif filter.include?("sb_2")
          filter = "피지 개수 코"
        elsif filter.include?("sb_7")
          filter = "피지 개수 우측 볼"
        elsif filter.include?("sb_8")
          filter = "피지 개수 좌측 볼"
        elsif filter.include?("sb_avr")
          filter = "피지 개수 평균"
        elsif filter.include?("pp_1")
          filter = "포피린 개수 이마"
        elsif filter.include?("pp_2")
          filter = "포피린 개수 코"
        elsif filter.include?("pp_7")
          filter = "포피린 개수 우측 볼"
        elsif filter.include?("pp_8")
          filter = "포피린 개수 좌측 볼"
        elsif filter.include?("pp_avr")
          filter = "포피린 개수 평균"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 이마"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 코"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 우측 볼"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 좌측 볼"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 평균"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정 이마"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정 코"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정 평균"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정 이마"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정 코"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정 평균"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정 이마"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정 코"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정 우측 눈밑"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정 좌측 눈밑"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정 우측 볼"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정 좌측 볼"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정 평균"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red 이마"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red 코"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red 우측 눈밑"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red 좌측 눈밑"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red 우측 볼"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red 좌측 볼"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red 평균"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green 이마"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green 코"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green 우측 눈밑"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green 좌측 눈밑"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green 우측 볼"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green 좌측 볼"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green 평균"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue 이마"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue 코"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue 우측 눈밑"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue 좌측 눈밑"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue 우측 볼"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue 좌측 볼"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue 평균"
        elsif filter.include?("lab_l")
          filter = "피부색 L 값"
        elsif filter.include?("lab_a")
          filter = "피부색 a 값"
        elsif filter.include?("lab_b")
          filter = "피부색 b 값"
        elsif filter.include?("e_sebum_t")
          filter = "피지 E 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피지 E 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter == "skintype"
          filter = "피부타입(야누스 측정)"
        elsif filter.include?("m_skintype")
          filter = "피부타입(설문 로직)"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("e_porphyrin_t")
          filter = "포피린 E 값(T존)"
        elsif filter.include?("e_porphyrin_u")
          filter = "포피린 E 값(U존)"
        elsif filter.include?("shop_cd")
          filter = "매장코드"
        else
          filter = filter
        end
        @excel_name << filter
      end
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
    scoped = scoped.order("fcdata.measuredate desc")
    @fcdatas = scoped
    @fcdatas.each do |fcdata|
      fctabletinterview = Fctabletinterview.where.not(skin_type: nil).where.not(before_solution_1: nil).where.not(before_solution_2: nil).where(custserial: fcdata.custserial.to_i).where(fcdata_id: fcdata.measureno.to_i).first
      is_contain = true

      if !fctabletinterview.nil?
        if !@select_skin_anxiety1_array.blank?
          if !@select_skin_anxiety1_array.include?(fctabletinterview.before_solution_1)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@select_skin_anxiety2_array.blank?
          if !@select_skin_anxiety2_array.include?(fctabletinterview.before_solution_2)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@skin_type_survey_array.blank?
          if !@skin_type_survey_array.include?(fctabletinterview.skin_type)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@select_makeup.blank? && @select_makeup != "all"
          if fctabletinterview.a_1 != @select_makeup.to_i
            is_contain = false
          end
        end

        if !@select_mode.blank? && @select_mode != "all"
          if fctabletinterview.is_quick_mode != @select_mode
            is_contain = false
          end
        end
      else
        is_contain = false
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
      history.category = "Fcdata"
      history.save
    end

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
    start_measureno = params[:start_measureno]
    end_measureno = params[:end_measureno]
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
    @start_measureno = start_measureno
    @end_measureno = end_measureno
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
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

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
    scoped = scoped.where("fcdata.shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?
    scoped = scoped.where(custserial: serial_array) if @select_senstive != "all"
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fcdata.uptdate) >= ? AND to_date(fcdata.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where("fcdata.measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
    scoped = scoped.where("fcdata.measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
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

    if @select_filter == []
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일","수분 측정 이마","수분 측정 우측 볼","수분 측정 좌측 볼","모공 측정 이마","모공 측정 코","모공 측정 우측 볼","모공 측정 좌측 볼","모공 측정 평균","주름 측정 우측 눈옆", "주름 측정 우측 눈밑", "주름 측정 좌측 눈옆","주름 측정 좌측 눈밑", "주름 측정 평균",
      "탄력 측정 우측 볼", "탄력 측정 좌측 볼", "탄력 측정 평균", "탄력 각도 우측 볼", "탄력 각도 좌측 볼", "피지 개수 이마", "피지 개수 코", "피지 개수 우측 볼", "피지 개수 좌측 볼", "피지 개수 평균", "포피린 개수 이마", "포피린 개수 코", "포피린 개수 우측 볼", "포피린 개수 좌측 볼", "포피린 개수 평균",
      "포피린 비 이마", "포피린 비 코", "포피린 비 우측 볼", "포피린 비 좌측 볼", "포피린 비 평균", "편광 색소침착 측정 이마", "편광 색소침착 측정 코", "편광 색소침착 측정 우측 눈옆", "편광 색소침착 측정 우측 눈밑", "편광 색소침착 측정 좌측 눈옆", "편광 색소침착 측정 좌측 눈밑", "편광 색소침착 측정 우측 볼", "편광 색소침착 측정 좌측 볼", "편광 색소침착 측정 평균",
      "UV광 색소침착 측정 이마", "UV광 색소침착 측정 코", "UV광 색소침착 측정 우측 눈옆","UV광 색소침착 측정 우측 눈밑","UV광 색소침착 측정 좌측 눈옆","UV광 색소침착 측정 좌측 눈밑","UV광 색소침착 측정 우측 볼","UV광 색소침착 측정 좌측 볼","UV광 색소침착 측정 평균","피부톤 측정 이마","피부톤 측정 코","피부톤 측정 우측 눈밑","피부톤 측정 좌측 눈밑","피부톤 측정 우측 볼","피부톤 측정 좌측 볼","피부톤 측정 평균",
      "피부톤 Red 이마","피부톤 Red 코","피부톤 Red 우측 눈밑","피부톤 Red 좌측 눈밑","피부톤 Red 우측 볼","피부톤 Red 좌측 볼","피부톤 Red 평균","피부톤 Green 이마","피부톤 Green 코","피부톤 Green 우측 눈밑","피부톤 Green 좌측 눈밑","피부톤 Green 우측 볼","피부톤 Green 좌측 볼","피부톤 Green 평균",
      "피부톤 Blue 이마","피부톤 Blue 코","피부톤 Blue 우측 눈밑","피부톤 Blue 좌측 눈밑","피부톤 Blue 우측 볼","피부톤 Blue 좌측 볼","피부톤 Blue 평균","피부색 L 값","피부색 a 값","피부색 b 값","피지 E 값 (T 존)","피지 E 값 (U 존)","피부톤","선 민감도","피부타입(야누스 측정)","피부타입(설문 로직)","동안각도 점수 우측","동안각도 점수 좌측",
      "포피린 E 값(T존)","포피린 E 값(U존)","매장코드","피부고민 1순위","피부고민 2순위","피부고민 1순위 최근","피부고민 2순위 최근"]
    else
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정 이마"
        elsif filter.include?("mo_7")
          filter = "수분 측정 우측 볼"
        elsif filter.include?("mo_8")
          filter = "수분 측정 좌측 볼"
        elsif filter.include?("pr_1")
          filter = "모공 측정 이마"
        elsif filter.include?("pr_2")
          filter = "모공 측정 코"
        elsif filter.include?("pr_7")
          filter = "모공 측정 우측 볼"
        elsif filter.include?("pr_8")
          filter = "모공 측정 좌측 볼"
        elsif filter.include?("pr_avr")
          filter = "모공 측정 평균"
        elsif filter.include?("wr_3")
          filter = "주름 측정 우측 눈옆"
        elsif filter.include?("wr_4")
          filter = "주름 측정 우측 눈밑"
        elsif filter.include?("wr_5")
          filter = "주름 측정 좌측 눈옆"
        elsif filter.include?("wr_6")
          filter = "주름 측정 좌측 눈밑"
        elsif filter.include?("wr_avr")
          filter = "수분 측정 평균"
        elsif filter.include?("el_7")
          filter = "탄력 측정 우측 볼"
        elsif filter.include?("el_8")
          filter = "탄력 측정 좌측 볼"
        elsif filter.include?("el_avr")
          filter = "탄력 측정 평균"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도 우측 볼"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도 좌측 볼"
        elsif filter.include?("sb_1")
          filter = "피지 개수 이마"
        elsif filter.include?("sb_2")
          filter = "피지 개수 코"
        elsif filter.include?("sb_7")
          filter = "피지 개수 우측 볼"
        elsif filter.include?("sb_8")
          filter = "피지 개수 좌측 볼"
        elsif filter.include?("sb_avr")
          filter = "피지 개수 평균"
        elsif filter.include?("pp_1")
          filter = "포피린 개수 이마"
        elsif filter.include?("pp_2")
          filter = "포피린 개수 코"
        elsif filter.include?("pp_7")
          filter = "포피린 개수 우측 볼"
        elsif filter.include?("pp_8")
          filter = "포피린 개수 좌측 볼"
        elsif filter.include?("pp_avr")
          filter = "포피린 개수 평균"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 이마"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 코"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 우측 볼"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 좌측 볼"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 평균"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정 이마"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정 코"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정 평균"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정 이마"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정 코"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정 평균"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정 이마"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정 코"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정 우측 눈밑"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정 좌측 눈밑"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정 우측 볼"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정 좌측 볼"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정 평균"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red 이마"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red 코"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red 우측 눈밑"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red 좌측 눈밑"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red 우측 볼"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red 좌측 볼"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red 평균"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green 이마"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green 코"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green 우측 눈밑"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green 좌측 눈밑"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green 우측 볼"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green 좌측 볼"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green 평균"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue 이마"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue 코"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue 우측 눈밑"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue 좌측 눈밑"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue 우측 볼"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue 좌측 볼"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue 평균"
        elsif filter.include?("lab_l")
          filter = "피부색 L 값"
        elsif filter.include?("lab_a")
          filter = "피부색 a 값"
        elsif filter.include?("lab_b")
          filter = "피부색 b 값"
        elsif filter.include?("e_sebum_t")
          filter = "피지 E 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피지 E 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter == "skintype"
          filter = "피부타입(야누스 측정)"
        elsif filter.include?("m_skintype")
          filter = "피부타입(설문 로직)"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("e_porphyrin_t")
          filter = "포피린 E 값(T존)"
        elsif filter.include?("e_porphyrin_u")
          filter = "포피린 E 값(U존)"
        elsif filter.include?("shop_cd")
          filter = "매장코드"
        elsif filter.include?("worry_skin_1")
          filter = "피부고민 1순위"
        elsif filter.include?("worry_skin_2")
          filter = "피부고민 2순위"
        elsif filter.include?("worry_skin_new_1")
          filter = "피부고민 1순위 최근"
        elsif filter.include?("worry_skin_new_2")
          filter = "피부고민 2순위 최근"
        else
          filter = filter
        end
        @excel_name << filter
      end
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
    end
    scoped = scoped.order("fcdata.measuredate desc")

    @fcdatas = scoped.uniq
    @count = @fcdatas.count
    @fcdatas_excel = @fcdatas
    @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)

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
      history.category = "Fcdata"
      history.save
    end

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
    start_measureno = params[:start_measureno]
    end_measureno = params[:end_measureno]
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
    @start_measureno = start_measureno
    @end_measureno = end_measureno
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
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

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


    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where("fcdata.shop_cd LIKE '%#{@shop_cd}%'") if !@shop_cd.blank?
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fcdata.uptdate) >= ? AND to_date(fcdata.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where("fcdata.measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
    scoped = scoped.where("fcdata.measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"
    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
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
    end

    scoped = scoped.order("fcdata.measuredate desc")

    if @select_filter == []
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일","수분 측정 이마","수분 측정 우측 볼","수분 측정 좌측 볼","모공 측정 이마","모공 측정 코","모공 측정 우측 볼","모공 측정 좌측 볼","모공 측정 평균","주름 측정 우측 눈옆", "주름 측정 우측 눈밑", "주름 측정 좌측 눈옆","주름 측정 좌측 눈밑", "주름 측정 평균",
      "탄력 측정 우측 볼", "탄력 측정 좌측 볼", "탄력 측정 평균", "탄력 각도 우측 볼", "탄력 각도 좌측 볼", "피지 개수 이마", "피지 개수 코", "피지 개수 우측 볼", "피지 개수 좌측 볼", "피지 개수 평균", "포피린 개수 이마", "포피린 개수 코", "포피린 개수 우측 볼", "포피린 개수 좌측 볼", "포피린 개수 평균",
      "포피린 비 이마", "포피린 비 코", "포피린 비 우측 볼", "포피린 비 좌측 볼", "포피린 비 평균", "편광 색소침착 측정 이마", "편광 색소침착 측정 코", "편광 색소침착 측정 우측 눈옆", "편광 색소침착 측정 우측 눈밑", "편광 색소침착 측정 좌측 눈옆", "편광 색소침착 측정 좌측 눈밑", "편광 색소침착 측정 우측 볼", "편광 색소침착 측정 좌측 볼", "편광 색소침착 측정 평균",
      "UV광 색소침착 측정 이마", "UV광 색소침착 측정 코", "UV광 색소침착 측정 우측 눈옆","UV광 색소침착 측정 우측 눈밑","UV광 색소침착 측정 좌측 눈옆","UV광 색소침착 측정 좌측 눈밑","UV광 색소침착 측정 우측 볼","UV광 색소침착 측정 좌측 볼","UV광 색소침착 측정 평균","피부톤 측정 이마","피부톤 측정 코","피부톤 측정 우측 눈밑","피부톤 측정 좌측 눈밑","피부톤 측정 우측 볼","피부톤 측정 좌측 볼","피부톤 측정 평균",
      "피부톤 Red 이마","피부톤 Red 코","피부톤 Red 우측 눈밑","피부톤 Red 좌측 눈밑","피부톤 Red 우측 볼","피부톤 Red 좌측 볼","피부톤 Red 평균","피부톤 Green 이마","피부톤 Green 코","피부톤 Green 우측 눈밑","피부톤 Green 좌측 눈밑","피부톤 Green 우측 볼","피부톤 Green 좌측 볼","피부톤 Green 평균",
      "피부톤 Blue 이마","피부톤 Blue 코","피부톤 Blue 우측 눈밑","피부톤 Blue 좌측 눈밑","피부톤 Blue 우측 볼","피부톤 Blue 좌측 볼","피부톤 Blue 평균","피부색 L 값","피부색 a 값","피부색 b 값","피지 E 값 (T 존)","피지 E 값 (U 존)","피부톤","선 민감도","피부타입(야누스 측정)","피부타입(설문 로직)","동안각도 점수 우측","동안각도 점수 좌측",
      "포피린 E 값(T존)","포피린 E 값(U존)","매장코드"]
    else
      @excel_name = ["시리얼","이름","측정 당시 만 나이","성별","바코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("mo_1")
          filter = "수분 측정 이마"
        elsif filter.include?("mo_7")
          filter = "수분 측정 우측 볼"
        elsif filter.include?("mo_8")
          filter = "수분 측정 좌측 볼"
        elsif filter.include?("pr_1")
          filter = "모공 측정 이마"
        elsif filter.include?("pr_2")
          filter = "모공 측정 코"
        elsif filter.include?("pr_7")
          filter = "모공 측정 우측 볼"
        elsif filter.include?("pr_8")
          filter = "모공 측정 좌측 볼"
        elsif filter.include?("pr_avr")
          filter = "모공 측정 평균"
        elsif filter.include?("wr_3")
          filter = "주름 측정 우측 눈옆"
        elsif filter.include?("wr_4")
          filter = "주름 측정 우측 눈밑"
        elsif filter.include?("wr_5")
          filter = "주름 측정 좌측 눈옆"
        elsif filter.include?("wr_6")
          filter = "주름 측정 좌측 눈밑"
        elsif filter.include?("wr_avr")
          filter = "수분 측정 평균"
        elsif filter.include?("el_7")
          filter = "탄력 측정 우측 볼"
        elsif filter.include?("el_8")
          filter = "탄력 측정 좌측 볼"
        elsif filter.include?("el_avr")
          filter = "탄력 측정 평균"
        elsif filter.include?("el_angle_7")
          filter = "탄력 각도 우측 볼"
        elsif filter.include?("el_angle_8")
          filter = "탄력 각도 좌측 볼"
        elsif filter.include?("sb_1")
          filter = "피지 개수 이마"
        elsif filter.include?("sb_2")
          filter = "피지 개수 코"
        elsif filter.include?("sb_7")
          filter = "피지 개수 우측 볼"
        elsif filter.include?("sb_8")
          filter = "피지 개수 좌측 볼"
        elsif filter.include?("sb_avr")
          filter = "피지 개수 평균"
        elsif filter.include?("pp_1")
          filter = "포피린 개수 이마"
        elsif filter.include?("pp_2")
          filter = "포피린 개수 코"
        elsif filter.include?("pp_7")
          filter = "포피린 개수 우측 볼"
        elsif filter.include?("pp_8")
          filter = "포피린 개수 좌측 볼"
        elsif filter.include?("pp_avr")
          filter = "포피린 개수 평균"
        elsif filter.include?("pp_ratio_1")
          filter = "포피린 비 이마"
        elsif filter.include?("pp_ratio_2")
          filter = "포피린 비 코"
        elsif filter.include?("pp_ratio_7")
          filter = "포피린 비 우측 볼"
        elsif filter.include?("pp_ratio_8")
          filter = "포피린 비 좌측 볼"
        elsif filter.include?("pp_ratio_avr")
          filter = "포피린 비 평균"
        elsif filter.include?("sp_pl_1")
          filter = "편광 색소침착 측정 이마"
        elsif filter.include?("sp_pl_2")
          filter = "편광 색소침착 측정 코"
        elsif filter.include?("sp_pl_3")
          filter = "편광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_pl_4")
          filter = "편광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_pl_5")
          filter = "편광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_pl_6")
          filter = "편광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_pl_7")
          filter = "편광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_pl_8")
          filter = "편광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_pl_avr")
          filter = "편광 색소침착 측정 평균"
        elsif filter.include?("sp_uv_1")
          filter = "UV광 색소침착 측정 이마"
        elsif filter.include?("sp_uv_2")
          filter = "UV광 색소침착 측정 코"
        elsif filter.include?("sp_uv_3")
          filter = "UV광 색소침착 측정 우측 눈옆"
        elsif filter.include?("sp_uv_4")
          filter = "UV광 색소침착 측정 우측 눈밑"
        elsif filter.include?("sp_uv_5")
          filter = "UV광 색소침착 측정 좌측 눈옆"
        elsif filter.include?("sp_uv_6")
          filter = "UV광 색소침착 측정 좌측 눈밑"
        elsif filter.include?("sp_uv_7")
          filter = "UV광 색소침착 측정 우측 볼"
        elsif filter.include?("sp_uv_8")
          filter = "UV광 색소침착 측정 좌측 볼"
        elsif filter.include?("sp_uv_avr")
          filter = "UV광 색소침착 측정 평균"
        elsif filter.include?("sk_c_1")
          filter = "피부톤 측정 이마"
        elsif filter.include?("sk_c_2")
          filter = "피부톤 측정 코"
        elsif filter.include?("sk_c_4")
          filter = "피부톤 측정 우측 눈밑"
        elsif filter.include?("sk_c_6")
          filter = "피부톤 측정 좌측 눈밑"
        elsif filter.include?("sk_c_7")
          filter = "피부톤 측정 우측 볼"
        elsif filter.include?("sk_c_8")
          filter = "피부톤 측정 좌측 볼"
        elsif filter.include?("sk_c_avr")
          filter = "피부톤 측정 평균"
        elsif filter.include?("sk_r_1")
          filter = "피부톤 Red 이마"
        elsif filter.include?("sk_r_2")
          filter = "피부톤 Red 코"
        elsif filter.include?("sk_r_4")
          filter = "피부톤 Red 우측 눈밑"
        elsif filter.include?("sk_r_6")
          filter = "피부톤 Red 좌측 눈밑"
        elsif filter.include?("sk_r_7")
          filter = "피부톤 Red 우측 볼"
        elsif filter.include?("sk_r_8")
          filter = "피부톤 Red 좌측 볼"
        elsif filter.include?("sk_r_avr")
          filter = "피부톤 Red 평균"
        elsif filter.include?("sk_g_1")
          filter = "피부톤 Green 이마"
        elsif filter.include?("sk_g_2")
          filter = "피부톤 Green 코"
        elsif filter.include?("sk_g_4")
          filter = "피부톤 Green 우측 눈밑"
        elsif filter.include?("sk_g_6")
          filter = "피부톤 Green 좌측 눈밑"
        elsif filter.include?("sk_g_7")
          filter = "피부톤 Green 우측 볼"
        elsif filter.include?("sk_g_8")
          filter = "피부톤 Green 좌측 볼"
        elsif filter.include?("sk_g_avr")
          filter = "피부톤 Green 평균"
        elsif filter.include?("sk_b_1")
          filter = "피부톤 Blue 이마"
        elsif filter.include?("sk_b_2")
          filter = "피부톤 Blue 코"
        elsif filter.include?("sk_b_4")
          filter = "피부톤 Blue 우측 눈밑"
        elsif filter.include?("sk_b_6")
          filter = "피부톤 Blue 좌측 눈밑"
        elsif filter.include?("sk_b_7")
          filter = "피부톤 Blue 우측 볼"
        elsif filter.include?("sk_b_8")
          filter = "피부톤 Blue 좌측 볼"
        elsif filter.include?("sk_b_avr")
          filter = "피부톤 Blue 평균"
        elsif filter.include?("lab_l")
          filter = "피부색 L 값"
        elsif filter.include?("lab_a")
          filter = "피부색 a 값"
        elsif filter.include?("lab_b")
          filter = "피부색 b 값"
        elsif filter.include?("e_sebum_t")
          filter = "피지 E 값 (T 존)"
        elsif filter.include?("e_sebum_u")
          filter = "피지 E 값 (U 존)"
        elsif filter.include?("colortype")
          filter = "피부톤"
        elsif filter.include?("suntype")
          filter = "선 민감도"
        elsif filter == "skintype"
          filter = "피부타입(야누스 측정)"
        elsif filter.include?("m_skintype")
          filter = "피부타입(설문 로직)"
        elsif filter.include?("score_r")
          filter = "동안각도 점수 우측"
        elsif filter.include?("score_l")
          filter = "동안각도 점수 좌측"
        elsif filter.include?("e_porphyrin_t")
          filter = "포피린 E 값(T존)"
        elsif filter.include?("e_porphyrin_u")
          filter = "포피린 E 값(U존)"
        elsif filter.include?("shop_cd")
          filter = "매장코드"
        else
          filter = filter
        end
        @excel_name << filter
      end
    end
    
    @fcdatas.each do |fcdata|
      fctabletinterview = Fctabletinterviewrx.where.not(skin_type: nil).where.not(before_solution_1: nil).where.not(before_solution_2: nil).where(ch_cd: @ch_array).where(custserial: fcdata.custserial.to_i).where(fcdata_id: fcdata.measureno.to_i).first
      is_contain = true
      if !fctabletinterview.nil?
        if !@select_skin_anxiety1_array.blank?
          if !@select_skin_anxiety1_array.include?(fctabletinterview.before_solution_1)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@select_skin_anxiety2_array.blank?
          if !@select_skin_anxiety2_array.include?(fctabletinterview.before_solution_2)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@skin_type_survey_array.blank?
          if !@skin_type_survey_array.include?(fctabletinterview.skin_type)
            is_contain = false
          end
        else
          is_contain = false
        end

        if !@select_mode.blank? && @select_mode.downcase != "all"
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
      else
        is_contain = false
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

  def filter_check
    if params.has_key?(:ch_cd)
      @ch_cd = params[:ch_cd]
    end
  end
end
