class Admin::FcavgdataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcavgdatas = Fcavgdata.all
    @fcavgdatas = Kaminari.paginate_array(@fcavgdatas).page(params[:page]).per(3)
  end
end
