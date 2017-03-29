class Admin::FeedbackController < Admin::AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @date_today = (@date).strftime("%F")
    @date_2weeks_ago = (@date - 2.weeks).strftime("%F")
    @date_3months_ago = (@date - 3.months).strftime("%F")

    @is_admin_init = false
    if session[:admin_user]['role'] == "admin" || session[:admin_user] == "user" && (!params.has_key?(:select_channel) && !params.has_key?(:select_shop))
      @is_admin_init = true
    end

    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
      fcdata_list = Fcdata.all
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
      fcdata_list = Fcdata.where("ch_cd LIKE ?", "%#{ch_cd}%").where("shop_cd LIKE ?", "%#{shop_cd}%")
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop] if !params[:select_shop].nil? && params[:select_shop] != "ALL"
    @ch_cd = ch_cd
    @shop_cd = shop_cd

    serial_array = fcdata_list.where("custserial < ? ", 1001).pluck(:custserial).uniq
    serial_array2 = fcdata_list.where("custserial > ? AND custserial < ? ", 1001, 2001).pluck(:custserial).uniq
    measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

    Rails.logger.info serial_array.count
    if Rails.env.production? || Rails.env.staging?
      @tablet_interviews_today = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("uptdate desc")
      @tablet_interviews_today2 = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array2).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("uptdate desc")
      @tablet_interviews_today = @tablet_interviews_today + @tablet_interviews_today2
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 2.weeks).to_s)).order("uptdate desc")
      @tablet_interviews_2_weeks_ago2 = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array2).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 2.weeks).to_s)).order("uptdate desc")
      @tablet_interviews_2_weeks_ago = @tablet_interviews_2_weeks_ago + @tablet_interviews_2_weeks_ago2
      @tablet_interviews_3_months_ago = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("uptdate desc")
      @tablet_interviews_3_months_ago2 = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array2).where(fcdata_id: measureno_array).where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("uptdate desc")
      @tablet_interviews_3_months_ago = @tablet_interviews_3_months_ago + @tablet_interviews_3_months_ago2
    else
      @tablet_interviews_today = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array)
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array)
      @tablet_interviews_3_months_ago = Fctabletinterview.where(ch_cd: "CNP").where(custserial: serial_array).where(fcdata_id: measureno_array)
    end

    create_new_fcafterservice(@tablet_interviews_today)
    create_new_fcafterservice(@tablet_interviews_2_weeks_ago)
    create_new_fcafterservice(@tablet_interviews_3_months_ago)
  end

  def create_new_fcafterservice(relation)
    relation.each do |tabletinterview|
      custinfo = Custinfo.where(custserial: tabletinterview.custserial).last
      if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).count == 0 && (custinfo.ch_cd == "CNP" || custinfo.ch_cd == "CLAB")
        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.tablet_interview_update = tabletinterview.uptdate
        after_interview.order = 0
        after_interview.save

        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.tablet_interview_update = tabletinterview.uptdate
        after_interview.order = 1
        after_interview.save

        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.tablet_interview_update = tabletinterview.uptdate
        after_interview.order = 2
        after_interview.save
      end
    end
  end

  def show
    userId = params[:userId]
    @user = Custinfo.where(custserial: userId).first
    @after_interview = Fcafterinterview.where(after_interview_id: params[:after_interview_id]).first
  end

  def list
    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end
    @start_date = Date.today
    @end_date = Date.today
    @today = Date.today

    min_age_custinfo = Custinfo.where("ch_cd LIKE ?", "%#{ch_cd}%").where.not(birthyy: nil).order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i + 1
    max_age_custinfo = Custinfo.where("ch_cd LIKE ?", "%#{ch_cd}%").order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i + 1

    begin
      @start_date = Fctabletinterview.all.minimum(:uptdate).to_date
    rescue
    end

    @average_a1 = 0
    @average_a2 = 0
    @average_a3 = 0
    @average_a4 = 0

    select_sex = params[:sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    select_base = params[:select_base]
    select_ample1 = params[:select_ample1]
    select_ample2 = params[:select_ample2]
    select_interview = params[:select_interview]
    name = params[:name]

    if !start_date.nil?
      @start_date = start_date.to_time
    end
    if !end_date.nil?
      @end_date = end_date.to_time
    end
    if !select_sex.nil?
      @sex = select_sex
    end

    if !start_age.nil?
      @start_age = start_age
    end

    if !end_age.nil?
      @end_age = end_age
    end

    if !select_base.nil?
      @select_base = select_base
    end
    if !select_ample1.nil?
      @select_ample1 = select_ample1
    end
    if !select_ample2.nil?
      @select_ample2 = select_ample2
    end
    if !select_interview.nil?
      @select_interview = select_interview
    end
    if !name.nil?
      @name = name
    end

    @after_interviews = []

    if ch_cd == "" || ch_cd == "CNP" || ch_cd == "CLAB"
      if ch_cd == ""
        fcdata_list = Fcdata.all
      else
        fcdata_list = Fcdata.where("ch_cd LIKE ?", "%#{ch_cd}%").where("shop_cd LIKE ?", "%#{shop_cd}%")
      end

      temp_serial_array = fcdata_list.where("custserial < ? ", 1001).pluck(:custserial).uniq
      temp_serial_array2 = fcdata_list.where("custserial > ? AND custserial < ? ", 1001, 2001).pluck(:custserial).uniq
      temp_measureno_array = fcdata_list.pluck(:measureno).map(&:to_i).uniq

      tablet_interviews = Fctabletinterview.where(custserial: temp_serial_array).where(fcdata_id: temp_measureno_array)
      tablet_interviews2 = Fctabletinterview.where(custserial: temp_serial_array2).where(fcdata_id: temp_measureno_array)
      tablet_interviews = tablet_interviews + tablet_interviews2
      Rails.logger.info tablet_interviews.count
      array = tablet_interviews.pluck(:tablet_interview_id)
      temp_after_interviews = Fcafterinterview.where.not(a1: nil).where(tablet_interview_id: array)
      Rails.logger.info temp_after_interviews.count
      if select_interview != "all"
        if select_interview == "today"
          temp_after_interviews = temp_after_interviews.where(order: 0)
        elsif select_interview == "2weeks_ago"
          temp_after_interviews = temp_after_interviews.where(order: 1)
        elsif select_interview == "3months_ago"
          temp_after_interviews = temp_after_interviews.where(order: 2)
        end
      end

      Rails.logger.info temp_after_interviews.count
      temp_after_interviews.each do |after_interview|
        is_contain = true

        Fctabletinterview.where(tablet_interview_id: after_interview.tablet_interview_id).first

        custinfo = Custinfo.where(custserial: after_interview.custserial).first
        if !name.nil?
          if !custinfo.custname.include? name
             is_contain = false
          end
        end

        if custinfo.ch_cd.nil?
          is_contain = false
        end

        if select_sex != "all"
          if custinfo.sex != select_sex
            is_contain = false
          end
        end

        temp_age = Time.current.year.to_i - custinfo.birthyy.to_i + 1
        if temp_age < start_age.to_i || temp_age > end_age.to_i
          is_contain = false
        end

        tablet_interview = Fctabletinterview.where(tablet_interview_id: after_interview.tablet_interview_id).first
        if !(tablet_interview.uptdate.to_date >= @start_date && tablet_interview.uptdate.to_date <= @end_date.to_date)
          is_contain = false
        end

        if select_base != "all"
          if tablet_interview.after_serum != select_base
            is_contain = false
          end
        end
        if select_ample1 != "all"
          if tablet_interview.after_ample_1 != select_ample1
            is_contain = false
          end
        end
        if select_ample2 != "all"
          if tablet_interview.after_ample_2 != select_ample2
            is_contain = false
          end
        end

        if is_contain == true
          @after_interviews << after_interview
        end
      end
    end

    @after_interviews.each do |interview|
      @average_a1 = @average_a1 + interview.a1.to_i
      @average_a2 = @average_a2 + interview.a2.to_i
      @average_a3 = @average_a3 + interview.a3.to_i
      @average_a4 = @average_a4 + interview.a4.to_i
    end

    @count = @after_interviews.count
    divider = 0
    if @count != 0
      divider = @count
    end
    if @average_a1 != 0
      @average_a1 = (@average_a1 / divider).to_f
    end
    if @average_a2 != 0
      @average_a2 = (@average_a2 / divider).to_f
    end
    if @average_a3 != 0
      @average_a3 = (@average_a3 / divider).to_f
    end
    if @average_a4 != 0
      @average_a4 = (@average_a4 / divider).to_f
    end

    @after_interviews_excel = @after_interviews
    @after_interviews = Kaminari.paginate_array(@after_interviews).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end
