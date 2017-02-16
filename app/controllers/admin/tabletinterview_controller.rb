class Admin::TabletinterviewController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @start_date = Date.today
    @end_date = Date.today
    @today = Date.today

    select_sex = params[:sex]
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
    @start_date = start_date if !start_date.empty?
    @end_date = end_date  if !end_date.empty?
    @start_age = start_age
    @end_age = end_age
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

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @min_birthmm = min_age_custinfo.birthmm
    max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @max_birthyy = max_age_custinfo.birthyy
    @max_birthmm = max_age_custinfo.birthmm

    @start_age = @min_age if @start_age.empty?
    @end_age = @max_age if @end_age.empty?

    @start_birthyy = @max_birthyy if @start_birthyy.empty?
    @end_birthyy = @min_birthyy if @end_birthyy.empty?

    @start_birthmm = 1 if @start_birthmm.empty?
    @end_birthmm = 12 if @end_birthmm.empty?

    if Rails.env.production? || Rails.env.staging?
      scoped = Fctabletinterview.all
      temp_end_date = @end_date.to_date + 1.day
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
      scoped = scoped.where(custserial: @custserial) if !@custserial.empty?
      scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.empty? && @select_channel.downcase != "all"

      if !@select_mode.empty?
        if @select_mode.downcase != "all"
          if @select_mode == "quick"
            scoped = scoped.where(is_quick_mode: "T")
          end
        end
      end

      if !@select_makeup.empty?
        if @select_makeup.downcase != "all"
          scoped = scoped.where(is_make_up: @select_makeup)
        end
      end

      @tabletinterviews = Array.new
      scoped = scoped.order("uptdate desc")

      scoped.each do |tabletinterview|
        custinfo = Custinfo.where(custserial: tabletinterview.custserial).first
        is_conatin = true

        if !@name.empty?
          if !custinfo.custname.include? @name
             is_contain = false
          end
        end

        if @select_sex != "all"
          if custinfo.sex != @select_sex
            is_contain = false
          end
        end

        temp_age = Time.current.year.to_i - custinfo.birthyy.to_i
        if temp_age < @start_age.to_i || temp_age > @end_age.to_i
          is_contain = false
        end

        if custinfo.birthyy >= @start_birthyy.to_i || custinfo.birthyy <= @end_birthyy.to_i
          is_contain = false
        end

        if custinfo.birthmm >= @start_birthmm.to_i || custinfo.birthmm <= @end_birthmm.to_i
          is_contain = false
        end

        @tabletinterviews << tabletinterview if is_contain
      end
    else
      @tabletinterviews = Fctabletinterview.all
    end
  end

end
