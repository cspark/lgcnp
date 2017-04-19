class Api::Schedule::ScheduleFcscheduleController < Api::ApplicationController
  def index
    # Calendar 에서 월 선택 시 해당 월에 예약이 존재하는지 확인 RESERVE_MMDD 오름차순으로 정렬
    # 년월일, 채널코드, 매장코드 조건 (* Next 조회 필요)
    fcschedule = Fcschedule.where(ch_cd: params[:ch_cd], shop_cd: params[:shop_cd], reserve_yyyy: params[:reserve_yyyy], reserve_mmdd: params[:reserve_mmdd], reserve_hhmm: params[:reserve_hhmm]).first
    if !fcschedule.nil?
      render json: fcschedule.to_api_hash, status: :ok
    else
      render :text => "Fcschedule is not exist!!!", status: 204
    end
  end

  def month_list
    # 예약 스케줄 정보 추가/수정 시 해당 년월일로 조회하여 예약 스케줄 정보가 존재하는지 확인
    list = Fcschedule.month_list(ch_cd: params[:ch_cd], shop_cd: params[:shop_cd], reserve_yyyy: params[:reserve_yyyy], reserve_mm: params[:reserve_mmdd][0,2])
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "Fcschedule is not exist!!!", status: 204
    end
  end

  def today_list
    # 예약 스케줄 관리 프로그램 실행 시 팝업되는 '금일 예약자 리스트'에 추가될 오늘 날짜에 대한 예약스케줄 정보 확인 (* Next 조회 필요)
    list = Fcschedule.list(ch_cd: params[:ch_cd], shop_cd: params[:shop_cd], reserve_yyyy: params[:reserve_yyyy], reserve_mmdd: params[:reserve_mmdd]).order('reserve_hhmm ASC')
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "Fcschedule is not exist!!!", status: 204
    end
  end

  def create
    # 예약 스케줄 정보 추가
    fcschedule = Fcschedule.new(permitted_params)
    t = Time.now
    fcschedule.uptdate = t.to_s.split(" ")[0]

    if fcschedule.save
      render json: fcschedule.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def update_reservation
    Rails.logger.info "update_reservation!!!"
    schedule = Fcschedule.list(ch_cd: params[:ch_cd], shop_cd: params[:shop_cd], reserve_yyyy: params[:reserve_yyyy], reserve_mmdd: params[:reserve_mmdd], reserve_hhmm: params[:reserve_hhmm]).first

    if !schedule.nil?
      Rails.logger.info schedule.reserve_hhmm
      if params.has_key?(:phone)
        schedule.phone = params[:phone]
      end
      if params.has_key?(:custname)
        schedule.custname = params[:custname]
      end
      if params.has_key?(:memo)
        schedule.memo = params[:memo]
      end
      if params.has_key?(:reserve_yn)
        schedule.reserve_yn = params[:reserve_yn]
      end
      if params.has_key?(:purchase_yn)
        schedule.purchase_yn = params[:purchase_yn]
      end

      t = Time.now
      schedule.uptdate = t.to_s.split(" ")[0]

      if schedule.save
        render json: schedule.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render :text => "Fcschedule is not exist!!!", status: 204
    end
  end

  def delete_schedule
    fcschedule = Fcschedule.where(reserve_yyyy: params[:reserve_yyyy], reserve_mmdd: params[:reserve_mmdd], reserve_hhmm: params[:reserve_hhmm], ch_cd: params[:ch_cd], shop_cd: params[:shop_cd])
    if fcschedule.count > 0
      if fcschedule.delete_all
        render :text => "Delete Complete", status: 200
      else
        render :text => "Delete Fail", status: 404
      end
    else
      render :text => "Fcschedule is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:ch_cd, :shop_cd, :reserve_yyyy, :reserve_mmdd, :reserve_mm, :reserve_hhmm, :custname, :phone, :reserve_yn, :memo, :uptdate, :purchase_yn, :custname)
  end
end
