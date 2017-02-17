class Admin::DataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcdatas = Fcdata.all.order("uptdate desc")
    
    @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(3)
  end
end
