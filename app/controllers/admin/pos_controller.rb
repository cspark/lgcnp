class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcpos = Fcpos.all.order("uptdate desc")
    @fcpos = Kaminari.paginate_array(@fcpos).page(params[:page]).per(3)
  end
end
