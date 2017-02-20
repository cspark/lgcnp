class Admin::ScheduleController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcschedules = Fcschedule.all.order("uptdate desc")
    @fcschedules = Kaminari.paginate_array(@fcschedules).page(params[:page]).per(3)
  end
end
