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
    @is_admin_init = true if session[:admin_user]['role'] == "admin" || session[:admin_user] == "user" && (!params.has_key?(:select_channel) && !params.has_key?(:select_shop))

    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    scoped = Fctabletinterview.where("ch_cd LIKE ?", "%#{@ch_cd}%")

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.shop_cd LIKE ?",  "#{@shop_cd}") if !@shop_cd.blank?
      @tablet_interviews_today = scoped.where("to_char(to_date(fctabletinterview.uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("fctabletinterview.uptdate desc")
      @tablet_interviews_2_weeks_ago = scoped.where("to_char(to_date(fctabletinterview.uptdate), 'YYYY-MM-DD') LIKE ?",  ((@date - 2.weeks).to_s)).order("fctabletinterview.uptdate desc")
      @tablet_interviews_3_months_ago = scoped.where("to_char(to_date(fctabletinterview.uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("fctabletinterview.uptdate desc")
    else
      @tablet_interviews_today = scoped.order("fctabletinterview.uptdate desc")
      @tablet_interviews_2_weeks_ago = scoped.order("fctabletinterview.uptdate desc")
      @tablet_interviews_3_months_ago = scoped.order("fctabletinterview.uptdate desc")
    end

    create_new_fcafterservice(@tablet_interviews_today)
    create_new_fcafterservice(@tablet_interviews_2_weeks_ago)
    create_new_fcafterservice(@tablet_interviews_3_months_ago)
  end

  def create_new_fcafterservice(relation)
    relation.each do |tabletinterview|
      custinfo = tabletinterview.custinfo
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

  def cnpr_show
    userId = params[:userId]
    @user = Custinfo.where(custserial: userId).first
    @after_interview = Fcafterinterviewrx.where(after_interview_id: params[:after_interview_id]).first
  end

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
      history.category = "Feedback"
      history.save
    end

    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    custserial = ""
    custserial = params[:custserial] if !params[:custserial].blank?
    @custserial = custserial

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first
    if !ch_cd.blank?
      min_age_custinfo = Custinfo.where(ch_cd: ch_cd).where.not(birthyy: nil).order("birthyy desc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i

    max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    if !ch_cd.blank?
      max_age_custinfo = Custinfo.where(ch_cd: ch_cd).order("birthyy asc").first
    end
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i

    @start_date = Date.today
    @end_date = Date.today
    @today = Date.today

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
    @start_date = start_date.to_time if !start_date.blank?
    @end_date = end_date.to_time if !end_date.blank?
    @sex = select_sex if !select_sex.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @select_base = select_base if !select_base.blank?
    @select_ample1 = select_ample1 if !select_ample1.blank?
    @select_ample2 = select_ample2 if !select_ample2.blank?
    @select_interview = select_interview if !select_interview.blank?
    @name = name if !name.blank?

    if !Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: "CNP").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @is_agree_thirdparty_info = params[:is_agree_thirdparty_info] if !params[:is_agree_thirdparty_info].blank?
    @is_init = true
    @is_init = false if params[:select_channel].present?

    @after_interviews = []

    scoped = Fcafterinterview.where.not(a1: nil)
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.shop_cd LIKE ?",  "#{shop_cd}") if !shop_cd.blank?
      scoped = scoped.joins(:fcdata).where("fcdata.ch_cd LIKE ?",  "#{ch_cd}") if !ch_cd.blank?
      scoped = scoped.joins(:fcdata).where("fcdata.custserial LIKE ?",  "#{custserial}") if !custserial.blank?
    end
    scoped = scoped.order("fcafterinterview.after_interview_id desc")

    if select_interview != "all"
      if select_interview == "today"
        scoped = scoped.where(order: 0)
      elsif select_interview == "2weeks_ago"
        scoped = scoped.where(order: 1)
      elsif select_interview == "3months_ago"
        scoped = scoped.where(order: 2)
      end
    end

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil?
      scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sec}%") if @sex != "all"
      if !@start_age.blank? && !@end_age.blank?
        start_birthyy = Time.current.year.to_i - @start_age.to_i
        end_birthyy = Time.current.year.to_i - @end_age.to_i
        scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
      end
      scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", "%#{params[:is_agree_thirdparty_info]}%") if params.has_key?(:is_agree_thirdparty_info)

      scoped = scoped.joins(:fctabletinterview).where("to_date(fctabletinterview.uptdate) >= ? AND to_date(fctabletinterview.uptdate) < ?", @start_date, @end_date.to_date)

      scoped = scoped.joins(:fctabletinterview).where("fctabletinterview.after_serum LIKE ?", "#{select_base}") if select_base != "all"
      scoped = scoped.joins(:fctabletinterview).where("fctabletinterview.after_ample_1 LIKE ?", "#{select_ample1}") if select_ample1 != "all"
      scoped = scoped.joins(:fctabletinterview).where("fctabletinterview.after_ample_2 LIKE ?", "#{select_ample2}") if select_ample2 != "all"
    end
    @after_interviews = scoped

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

    @count = @after_interviews.count
    @after_interviews_excel = @after_interviews
    @after_interviews = Kaminari.paginate_array(@after_interviews).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def input_cnpr
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @date_today = (@date).strftime("%F")
    @date_2weeks_ago = (@date - 2.weeks).strftime("%F")
    @date_3months_ago = (@date - 3.months).strftime("%F")

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    if session[:admin_user] == "user" || (!session[:admin_user]['role'].nil? && session[:admin_user]['role'] == "admin")
      ch_cd = ""
      shop_cd = ""
    else
      ch_cd = session[:admin_user]['ch_cd']
      shop_cd = session[:admin_user]['shop_cd']
    end

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]

    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    scoped = Fctabletinterviewrx.all

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.ch_cd LIKE ?",  "#{@ch_cd}") if !@ch_cd.blank?
      scoped = scoped.joins(:fcdata).where("fcdata.shop_cd LIKE ?",  "#{@shop_cd}") if !@shop_cd.blank?
      @tablet_interviews_today = scoped.where("to_char(to_date(fctabletinterviewrx.uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("fctabletinterviewrx.uptdate desc")
      @tablet_interviews_2_weeks_ago = scoped.where("to_char(to_date(fctabletinterviewrx.uptdate), 'YYYY-MM-DD') LIKE ?",  ((@date - 2.weeks).to_s)).order("fctabletinterviewrx.uptdate desc")
      @tablet_interviews_3_months_ago = scoped.where("to_char(to_date(fctabletinterviewrx.uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("fctabletinterviewrx.uptdate desc")
    else
      @tablet_interviews_today = scoped.order("fctabletinterviewrx.uptdate desc")
      @tablet_interviews_2_weeks_ago = scoped.order("fctabletinterviewrx.uptdate desc")
      @tablet_interviews_3_months_ago = scoped.order("fctabletinterviewrx.uptdate desc")
    end

    create_new_fcafterservice_rx(@tablet_interviews_today)
    create_new_fcafterservice_rx(@tablet_interviews_2_weeks_ago)
    create_new_fcafterservice_rx(@tablet_interviews_3_months_ago)
  end

  def create_new_fcafterservice_rx(relation)
    relation.each do |tabletinterview|
      custinfo = Custinfo.where(custserial: tabletinterview.custserial).last
      if Fcafterinterviewrx.where(custserial: tabletinterview.custserial).where(rx_tablet_interview_id: tabletinterview.tablet_interview_id).where(order: 1).count == 0 && (custinfo.ch_cd == "CNPR" || custinfo.ch_cd == "RLAB")
        after_interview = Fcafterinterviewrx.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.rx_tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterviewrx.all.count
        after_interview.rx_tablet_interview_uptdate = tabletinterview.uptdate
        after_interview.order = 1
        after_interview.save

        after_interview = Fcafterinterviewrx.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.rx_tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterviewrx.all.count
        after_interview.rx_tablet_interview_uptdate = tabletinterview.uptdate
        after_interview.order = 2
        after_interview.save
      end
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
      history.category = "Feedback"
      history.save
    end

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

    min_age_custinfo = Custinfo.where(ch_cd: "CNPR").where.not(birthyy: nil).order("birthyy desc").first
    if !ch_cd.blank?
      min_age_custinfo = Custinfo.where(ch_cd: ch_cd).where.not(birthyy: nil).order("birthyy desc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i

    max_age_custinfo = Custinfo.where(ch_cd: "CNPR").order("birthyy asc").first
    if !ch_cd.blank?
      max_age_custinfo = Custinfo.where(ch_cd: ch_cd).order("birthyy asc").first
    end
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i

    begin
      @start_date = Fctabletinterviewrx.all.minimum(:uptdate).to_date
    rescue
    end

    @average_a1 = 0
    @average_a2 = 0
    @average_a3 = 0
    @average_a4 = 0
    @average_a5 = 0
    @average_a6 = 0

    select_sex = params[:sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    select_base = params[:select_base]
    select_interview = params[:select_interview]
    name = params[:name]


    @start_date = start_date.to_time if !start_date.blank?
    @end_date = end_date.to_time if !end_date.blank?
    @sex = select_sex if !select_sex.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @select_base = select_base if !select_base.blank?
    @select_interview = select_interview if !select_interview.blank?
    @name = name if !name.blank?

    if !Custinfo.where(ch_cd: "CNPR").where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: "CNPR").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "CNPR").order("birthyy asc").first
    end
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i
    @min_birthyy = min_age_custinfo.birthyy
    @max_birthyy = max_age_custinfo.birthyy
    @min_birthmm = 1
    @max_birthmm = 12

    @is_agree_thirdparty_info = params[:is_agree_thirdparty_info] if !params[:is_agree_thirdparty_info].blank?
    @is_init = true
    if params[:select_channel].present?
      @is_init = false
    end

    @after_interviews = []

    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd
    custserial = ""
    custserial = params[:custserial] if !params[:custserial].blank?

    scoped = Fcafterinterviewrx.where.not(a1: nil)
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:fcdata).where("fcdata.shop_cd LIKE ?",  "#{shop_cd}") if !shop_cd.blank?
      scoped = scoped.joins(:fcdata).where("fcdata.ch_cd LIKE ?",  "#{ch_cd}") if !ch_cd.blank?
      scoped = scoped.joins(:fcdata).where("fcdata.custserial LIKE ?",  "#{custserial}") if !custserial.blank?
    end
    scoped = scoped.order("fcafterinterviewrx.after_interview_id desc")

    if select_interview != "all"
      if select_interview == "today"
        scoped = scoped.where(order: 0)
      elsif select_interview == "2weeks_ago"
        scoped = scoped.where(order: 1)
      elsif select_interview == "3months_ago"
        scoped = scoped.where(order: 2)
      end
    end

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil?
      scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sec}%") if @sex != "all"
      if !@start_age.blank? && !@end_age.blank?
        start_birthyy = Time.current.year.to_i - @start_age.to_i
        end_birthyy = Time.current.year.to_i - @end_age.to_i
        scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
      end
      scoped = scoped.joins(:custinfo).where("custinfo.is_agree_thirdparty_info LIKE ?", "%#{params[:is_agree_thirdparty_info]}%") if params.has_key?(:is_agree_thirdparty_info)

      scoped = scoped.joins(:fctabletinterviewrx).where("to_date(fctabletinterviewrx.uptdate) >= ? AND to_date(fctabletinterviewrx.uptdate) < ?", @start_date, @end_date.to_date)
    end
    @after_interviews = scoped

    @after_interviews.each do |interview|
      @average_a1 = @average_a1 + interview.a1.to_i
      @average_a2 = @average_a2 + interview.a2.to_i
      @average_a3 = @average_a3 + interview.a3.to_i
      @average_a4 = @average_a4 + interview.a4.to_i
      @average_a5 = @average_a5 + interview.a5.to_i
      @average_a6 = @average_a6 + interview.a6.to_i
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
    if @average_a5 != 0
      @average_a5 = (@average_a5 / divider).to_f
    end
    if @average_a6 != 0
      @average_a6 = (@average_a6 / divider).to_f
    end

    @after_interviews_excel = @after_interviews
    @after_interviews = Kaminari.paginate_array(@after_interviews).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

end
