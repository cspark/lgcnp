class Admin::MigenAgreeController < Admin::AdminApplicationController
  def index
    @count = FcAgreeMigen.count
    @migen_agree = FcAgreeMigen.page(params[:page]).per(10)
  end
end
