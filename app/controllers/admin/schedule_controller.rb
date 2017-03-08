class Admin::ScheduleController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    # Time.current.year
    if !params[:select_date].blank?
      @select_date = params[:select_date]
    else
      @select_date = Date.today
    end

    select_year = @select_date.to_s.split("-")[0]
    select_mmdd = @select_date.to_s.split("-")[1]+@select_date.to_s.split("-")[2]

    scoped = Fcschedule.all
    scoped = scoped.where("reserve_yyyy = ?", select_year)
    scoped = scoped.where("reserve_mmdd = ?", select_mmdd)
    @fcschedules = scoped.order("reserve_hhmm asc")

    @fcschedules_excel = @fcschedules
    @fcschedules = Kaminari.paginate_array(@fcschedules).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @fcschedule = Fcschedule.where("phone LIKE ?", "%#{params[:phone]}%").where("reserve_mmdd LIKE ?","%#{params[:reserve_mmdd]}%").where("reserve_hhmm LIKE ?","%#{params[:reserve_hhmm]}%").first
  end
end
