class Api::Schedule::FcscheduleController < Api::ApplicationController
  def index
    # Calendar 에서 월 선택 시 해당 월에 예약이 존재하는지 확 RESERVE_MMDD 오름차순으로 정렬
    # 년월일, 채널코드, 매장코드 조건 (* Next 조회 필요)

    list = Fcschedule.all.order("shop_cd asc")
    render json: api_hash_for_list(list), status: :ok
  end

  def create
    # 예약 스케줄 정보 추가
    if !Fcschedule.where(shop_cd: params[:shop_cd]).first.nil?
      render :text => "Shop exist!!!", status: 404
      return
    end
    fcschedule = Fcschedule.new(permitted_params)
    t = Time.now
    fcschedule.uptdate = t.to_s.split(" ")[0]

    if fcschedule.save
      render json: fcschedule.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:ch_cd, :shop_cd, :reserve_yyyy, :reserve_mmdd, :reserve_hhmm, :custname, :phone, :reserve_yn, :memo, :uptdate, :purchase_yn)
  end
end
