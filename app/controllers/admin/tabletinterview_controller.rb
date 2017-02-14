class Admin::TabletinterviewController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @tabletinterviews = Fctabletinterview.all.order("uptdate desc").page(params[:page]).per(6)
  end

end
