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

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy desc").first
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

      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(3)
      @fcdatas_excel = @fcdatas
    else
      @fcdatas = Fcdata.all
      Rails.logger.info "development???"
      Rails.logger.info @fcdatas.count

      Rails.logger.info "development???"
      Rails.logger.info Custinfo.all.count
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(3)
    end

  end
end
