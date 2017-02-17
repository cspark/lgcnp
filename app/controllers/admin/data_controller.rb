class Admin::DataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcdatas = Fcdata.all.order("measureno desc")
    if params.has_key?(:name)
      @fcdatas.each do |fcdata|
        custinfo = Custinfo.where(custserial: fcdata.custserial).first
        if custinfo > 0
          @fcdatas = nil
          @fcdatas = custinfo
        end
      end
    end

    # scoped = joins(:custinfos).where("custinfos.custserial" => fcdata.custserial) if params[:name].present?

    @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(3)
  end
end
