class Api::Schedule::ScheduleFcshopController < Api::ApplicationController
  def index
    # Config에서 최초 매장코드 설정을 위하여 매장 테이블 전체 조회 (* Next 조회 필요)
    list = Fcshop.list(shop_cd: params[:shop_cd], shop_name: params[:shop_name], ch_cd: params[:ch_cd], tel_no: params[:tel_no], address: params[:address]).order('shop_cd asc')
    if !list.nil?
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end
end
