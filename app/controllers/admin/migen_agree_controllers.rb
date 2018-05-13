class Admin::MigenAgreeController < Admin::AdminApplicationController
  def index
    @count = FcAgreeMigen.count
    @migen_agree = FcAgreeMigen.all
    @migen_agree = Kaminari.paginate(@migen_agree).page(params[:page]).per(10)
  end
end
