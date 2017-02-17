class Admin::FeedbackController < Admin::AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @date_today = (@date).strftime("%F")
    @date_2weeks_ago = (@date - 2.weeks).strftime("%F")
    @date_3months_ago = (@date - 3.months).strftime("%F")
    if Rails.env.production? || Rails.env.staging?
      @tablet_interviews_today = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("uptdate desc")
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 2.weeks).to_s)).order("uptdate desc")
      @tablet_interviews_3_months_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("uptdate desc")
    else
      @tablet_interviews_today = Fctabletinterview.all
      @tablet_interviews_2_weeks_ago = Fctabletinterview.all
      @tablet_interviews_3_months_ago = Fctabletinterview.all
    end

    create_new_fcafterservice(@tablet_interviews_today)
    create_new_fcafterservice(@tablet_interviews_2_weeks_ago)
    create_new_fcafterservice(@tablet_interviews_3_months_ago)
  end

  def create_new_fcafterservice(relation)
    relation.each do |tabletinterview|
      if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).count == 0
        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.order = 0
        after_interview.save

        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.order = 1
        after_interview.save

        after_interview = Fcafterinterview.new
        after_interview.custserial = tabletinterview.custserial
        after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
        after_interview.after_interview_id = Fcafterinterview.all.count
        after_interview.order = 2
        after_interview.save
      end
    end
  end

  def list
    @start_date = Date.today
    @end_date = Date.today
    @today = Date.today

    min_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy desc").first
    @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
    max_age_custinfo = Custinfo.where(ch_cd: "CNP").order("birthyy asc").first
    @max_age = Time.current.year - max_age_custinfo.birthyy.to_i

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
    if Rails.env.production? || Rails.env.staging?
      temp_after_interviews = Fcafterinterview.where.not(a1: nil)
      if select_interview != "all"
        if select_interview == "today"
          temp_after_interviews = temp_after_interviews.where(order: 0)
        elsif select_interview == "2weeks_ago"
          temp_after_interviews = temp_after_interviews.where(order: 1)
        elsif select_interview == "3months_ago"
          temp_after_interviews = temp_after_interviews.where(order: 2)
        end
      end

      temp_after_interviews.each do |after_interview|
        is_contain = true
        custinfo = Custinfo.where(custserial: after_interview.custserial).first
        if !name.nil?
          if !custinfo.custname.include? name
             is_contain = false
          end
        end

        if select_sex != "all"
          if custinfo.sex != select_sex
            is_contain = false
          end
        end

        temp_age = Time.current.year.to_i - custinfo.birthyy.to_i
        if temp_age < start_age.to_i || temp_age > end_age.to_i
          is_contain = false
        end


        tablet_interview = Fctabletinterview.where(tablet_interview_id: after_interview.tablet_interview_id).first
        if !(tablet_interview.uptdate.to_date >= @start_date && tablet_interview.uptdate.to_date <= @end_date)
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

    @after_interviews = Kaminari.paginate_array(@after_interviews).page(params[:page]).per(5)

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
    render 'list'
  end
end
