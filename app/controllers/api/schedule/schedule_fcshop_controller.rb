class Api::Schedule::ScheduleFcshopController < Api::ApplicationController
  def index
    # Config에서 최초 매장코드 설정을 위하여 매장 테이블 전체 조회 (* Next 조회 필요)
    if params.has_key?(:ch_cd)
      list = Fcshop.where(ch_cd: params[:ch_cd]).order("shop_name asc")
    else
      list = Fcshop.all.order("shop_name asc")
    end
    render json: api_hash_for_list(list), status: :ok
  end
end
