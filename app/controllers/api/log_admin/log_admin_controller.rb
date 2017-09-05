class Api::LogAdmin::LogAdminController < Api::ApplicationController
  def index
    # Calendar 에서 월 선택 시 해당 월에 예약이 존재하는지 확인 RESERVE_MMDD 오름차순으로 정렬
    # 년월일, 채널코드, 매장코드 조건 (* Next 조회 필요)
    list = FclogAdmin.all.order("log_date desc")
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "FclogAdmin is not exist!!!", status: 204
    end
  end

  def create
    log = FclogAdmin.new(permitted_params)
    if log.save
      render json: log.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end


  private
  def permitted_params
    params.permit(:admin_id, :ip, :log_date, :work_name, :work_comment)
  end
end
