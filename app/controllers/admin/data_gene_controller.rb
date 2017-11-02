class Admin::DataGeneController < Admin::AdminApplicationController
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
    select_area = params[:select_area]
    select_skin_type_device = params[:select_skin_type_device]
    select_address = params[:select_address] if !params[:select_address].nil? && params[:select_address] != "ALL"

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
    @select_skin_type_device = params[:select_skin_type_device]
    @select_address = select_address if !select_address.blank?

    @is_agree_thirdparty_info = params[:is_agree_thirdparty_info] if !params[:is_agree_thirdparty_info].blank?
    @is_flag = params[:is_flag] if !params[:is_flag].blank?

    @is_init = true
    if params[:select_sex].present?
      @is_init = false
    end

    ch_cd = ""
    shop_cd = ""
    gene_barcode = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    gene_barcode = params[:gene_barcode]
    @ch_cd = ch_cd
    @shop_cd = shop_cd if !shop_cd.blank?
    @gene_barcode = gene_barcode if !gene_barcode.blank?

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
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?

    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
    scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"

    scoped = scoped.where(flag: @is_flag) if @is_flag == "T"
    flag_f_scoped = scoped.where(flag: @is_flag) if @is_flag == "F"
    flag_nil_scoped = scoped.where(flag: nil) if @is_flag == "F"
    scoped = flag_f_scoped.or(flag_nil_scoped) if @is_flag == "F"
    scoped = scoped.where(custserial: 0) if @is_flag.blank?

    if @select_skin_type_device_final.blank?
      scoped = scoped.where(skintype: [100])
    else
      scoped = scoped.where(skintype: @select_skin_type_device_final)
    end

    @excel_name = ["Flag","시리얼","이름","측정 당시 만 나이","성별","바코드","매장코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일","주소","설문1(키)","설문1(몸무게)","설문2","설문3","설문4","설문5","설문6","설문7","설문8","설문9","설문10","설문11","설문12","설문13","설문14","설문15(거주지)","설문15(출생지)",
    "수분 측정 이마","수분 측정 우측 볼","수분 측정 좌측 볼","모공 측정 이마","모공 측정 코","모공 측정 우측 볼","모공 측정 좌측 볼","모공 측정 평균","주름 측정 우측 눈옆", "주름 측정 우측 눈밑", "주름 측정 좌측 눈옆","주름 측정 좌측 눈밑", "주름 측정 평균",
    "탄력 측정 우측 볼", "탄력 측정 좌측 볼", "탄력 측정 평균", "탄력 각도 우측 볼", "탄력 각도 좌측 볼", "피지 개수 이마", "피지 개수 코", "피지 개수 우측 볼", "피지 개수 좌측 볼", "피지 개수 평균", "포피린 개수 이마", "포피린 개수 코", "포피린 개수 우측 볼", "포피린 개수 좌측 볼", "포피린 개수 평균",
    "포피린 비 이마", "포피린 비 코", "포피린 비 우측 볼", "포피린 비 좌측 볼", "포피린 비 평균", "편광 색소침착 측정 이마", "편광 색소침착 측정 코", "편광 색소침착 측정 우측 눈옆", "편광 색소침착 측정 우측 눈밑", "편광 색소침착 측정 좌측 눈옆", "편광 색소침착 측정 좌측 눈밑", "편광 색소침착 측정 우측 볼",
    "편광 색소침착 측정 좌측 볼", "편광 색소침착 측정 평균",
    "UV광 색소침착 측정 이마", "UV광 색소침착 측정 코", "UV광 색소침착 측정 우측 눈옆","UV광 색소침착 측정 우측 눈밑","UV광 색소침착 측정 좌측 눈옆","UV광 색소침착 측정 좌측 눈밑","UV광 색소침착 측정 우측 볼",
    "UV광 색소침착 측정 좌측 볼","UV광 색소침착 측정 평균","피부톤 측정 이마","피부톤 측정 코","피부톤 측정 우측 눈밑","피부톤 측정 좌측 눈밑","피부톤 측정 우측 볼","피부톤 측정 좌측 볼","피부톤 측정 평균",
    "피부톤 Red 이마","피부톤 Red 코","피부톤 Red 우측 눈밑","피부톤 Red 좌측 눈밑","피부톤 Red 우측 볼","피부톤 Red 좌측 볼","피부톤 Red 평균","피부톤 Green 이마","피부톤 Green 코","피부톤 Green 우측 눈밑","피부톤 Green 좌측 눈밑","피부톤 Green 우측 볼","피부톤 Green 좌측 볼","피부톤 Green 평균",
    "피부톤 Blue 이마","피부톤 Blue 코","피부톤 Blue 우측 눈밑","피부톤 Blue 좌측 눈밑","피부톤 Blue 우측 볼","피부톤 Blue 좌측 볼","피부톤 Blue 평균","피부색 L 값","피부색 a 값","피부색 b 값","피지 E 값 (T 존)","피지 E 값 (U 존)","피부톤","선 민감도","피부타입(야누스 측정)","피부타입(설문 로직)","동안각도 점수 우측","동안각도 점수 좌측",
    "포피린 E 값(T존)","포피린 E 값(U존)"]

    scoped = scoped.order("measuredate desc")

    scoped.each do |fcdata|
      custinfo = Custinfo.where(custserial: fcdata.custserial).first
      is_contain = true
      if custinfo != nil
        if custinfo.is_agree_thirdparty_info != nil && params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info] != "T,F"
          if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("T") && custinfo.is_agree_thirdparty_info == "F"
            is_contain = false
          end
          if params.has_key?(:is_agree_thirdparty_info) && params[:is_agree_thirdparty_info].include?("F") && custinfo.is_agree_thirdparty_info == "T"
            is_contain = false
          end
        end

        if (params.has_key?(:is_agree_thirdparty_info) != nil && params[:is_agree_thirdparty_info] == "") && !custinfo.is_agree_thirdparty_info.nil?
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
          temp_age = Time.current.year.to_i - custinfo.birthyy.to_i - 1
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

        if !@select_address.blank?
          if custinfo.address != @select_address
            is_contain = false
          end
        end
      else
        is_contain = false
      end

      if is_contain == true
        @fcdatas << fcdata
      end
    end

    @fcdatas.each do |fcdata|
      fcgene_interviews = FcgeneInterview.where(custserial: fcdata.custserial.to_i).where(measureno: fcdata.measureno.to_i)
      is_contain = true
      if fcgene_interviews.count > 1
        is_contain = false
      else
        fcgene_interview = fcgene_interviews.first
        if !fcgene_interview.nil?
          if !@gene_barcode.blank?
            if fcgene_interview.gene_barcode != @gene_barcode
              is_contain = false
            end
          end

        else
          is_contain = false
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
    @select_skin_type_device = params[:select_skin_type_device]
    @select_skin_type_survey = params[:select_skin_type_survey]

    @is_flag = params[:is_flag] if !params[:is_flag].blank?

    @is_init = true
    if params[:select_sex].present?
      @is_init = false
    end

    ch_cd = ""
    shop_cd = ""
    gene_barcode = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    gene_barcode = params[:gene_barcode]
    @ch_cd = ch_cd
    @shop_cd = shop_cd if !shop_cd.blank?
    @gene_barcode = gene_barcode if !gene_barcode.blank?

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

    scoped = Fcdata.where(ch_cd: @ch_array)
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
    scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
    scoped = scoped.where(faceno: @select_area) if !@select_area.blank? && @select_area.downcase != "all"
    scoped = scoped.where(m_skintype: 0) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode == "F"
    scoped = scoped.where(m_skintype: [1,2,3]) if !@select_mode.blank? && @select_mode.downcase != "all" && @select_mode == "T"

    scoped = scoped.where(flag: @is_flag) if @is_flag == "T"
    flag_f_scoped = scoped.where(flag: @is_flag) if @is_flag == "F"
    flag_nil_scoped = scoped.where(flag: nil) if @is_flag == "F"
    scoped = flag_f_scoped.or(flag_nil_scoped) if @is_flag == "F"
    scoped = scoped.where(custserial: 0) if @is_flag.blank?

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


    @excel_name = ["Flag","시리얼","이름","측정 당시 만 나이","성별","바코드","매장코드","생년월일","분석 횟수","채널","측정 부위","진단 날짜","업데이트 일","주소","설문1(키)","설문1(몸무게)","설문2","설문3","설문4","설문5","설문6","설문7","설문8","설문9","설문10","설문11","설문12","설문13","설문14","설문15(거주지)","설문15(출생지)",
    "수분 측정 이마","수분 측정 우측 볼","수분 측정 좌측 볼","모공 측정 이마","모공 측정 코","모공 측정 우측 볼","모공 측정 좌측 볼","모공 측정 평균","주름 측정 우측 눈옆", "주름 측정 우측 눈밑", "주름 측정 좌측 눈옆","주름 측정 좌측 눈밑", "주름 측정 평균",
    "탄력 측정 우측 볼", "탄력 측정 좌측 볼", "탄력 측정 평균", "탄력 각도 우측 볼", "탄력 각도 좌측 볼", "피지 개수 이마", "피지 개수 코", "피지 개수 우측 볼", "피지 개수 좌측 볼", "피지 개수 평균", "포피린 개수 이마", "포피린 개수 코", "포피린 개수 우측 볼", "포피린 개수 좌측 볼", "포피린 개수 평균",
    "포피린 비 이마", "포피린 비 코", "포피린 비 우측 볼", "포피린 비 좌측 볼", "포피린 비 평균", "편광 색소침착 측정 이마", "편광 색소침착 측정 코", "편광 색소침착 측정 우측 눈옆", "편광 색소침착 측정 우측 눈밑", "편광 색소침착 측정 좌측 눈옆", "편광 색소침착 측정 좌측 눈밑", "편광 색소침착 측정 우측 볼",
    "편광 색소침착 측정 좌측 볼", "편광 색소침착 측정 평균",
    "UV광 색소침착 측정 이마", "UV광 색소침착 측정 코", "UV광 색소침착 측정 우측 눈옆","UV광 색소침착 측정 우측 눈밑","UV광 색소침착 측정 좌측 눈옆","UV광 색소침착 측정 좌측 눈밑","UV광 색소침착 측정 우측 볼",
    "UV광 색소침착 측정 좌측 볼","UV광 색소침착 측정 평균","피부톤 측정 이마","피부톤 측정 코","피부톤 측정 우측 눈밑","피부톤 측정 좌측 눈밑","피부톤 측정 우측 볼","피부톤 측정 좌측 볼","피부톤 측정 평균",
    "피부톤 Red 이마","피부톤 Red 코","피부톤 Red 우측 눈밑","피부톤 Red 좌측 눈밑","피부톤 Red 우측 볼","피부톤 Red 좌측 볼","피부톤 Red 평균","피부톤 Green 이마","피부톤 Green 코","피부톤 Green 우측 눈밑","피부톤 Green 좌측 눈밑","피부톤 Green 우측 볼","피부톤 Green 좌측 볼","피부톤 Green 평균",
    "피부톤 Blue 이마","피부톤 Blue 코","피부톤 Blue 우측 눈밑","피부톤 Blue 좌측 눈밑","피부톤 Blue 우측 볼","피부톤 Blue 좌측 볼","피부톤 Blue 평균","피부색 L 값","피부색 a 값","피부색 b 값","피지 E 값 (T 존)","피지 E 값 (U 존)","피부톤","선 민감도","피부타입(야누스 측정)","피부타입(설문 로직)","동안각도 점수 우측","동안각도 점수 좌측",
    "포피린 E 값(T존)","포피린 E 값(U존)","피부고민 1순위","피부고민 2순위","피부고민 1순위 최근","피부고민 2순위 최근"]

    scoped = scoped.order("measuredate desc")

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
        temp_age = Time.current.year.to_i - custinfo.birthyy.to_i - 1
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

      if custinfo.nil?
        is_contain = false
      end

      if is_contain == true
        @fcdatas << fcdata
      end
    end

    @fcdatas.each do |fcdata|
      fcgene_interviews = FcgeneInterview.where(custserial: fcdata.custserial.to_i).where(measureno: fcdata.measureno.to_i)
      is_contain = true
      if fcgene_interviews.count > 1
        is_contain = false
      else
        fcgene_interview = fcgene_interviews.first
        if !fcgene_interview.nil?
          if !@gene_barcode.blank?
            if fcgene_interview.gene_barcode != @gene_barcode
              is_contain = false
            end
          end

        else
          is_contain = false
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

  def update
    data = Fcdata.where(custserial: params[:custserial], ch_cd: params[:ch_cd], measureno: params[:measureno]).first

    if !data.nil?
      data.flag = params[:flag] if params.has_key?(:flag)
      if data.save
        render json: {}, status: :ok
      else
        render json: {}, status: :bad_request
      end
    else
      render json: {}, status: :bad_request
    end
  end

end
