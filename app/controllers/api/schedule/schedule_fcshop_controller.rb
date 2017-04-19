class Api::Schedule::ScheduleFcshopController < Api::ApplicationController
  skip_before_action :authenticate, :only => [:get_api_key]
  
  def index
    # Config에서 최초 매장코드 설정을 위하여 매장 테이블 전체 조회 (* Next 조회 필요)
    list = Fcshop.all.order("shop_cd asc")
    render json: api_hash_for_list(list), status: :ok
  end
end
