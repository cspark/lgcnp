class Api::Beau::CnpUserController < Api::ApplicationController
  def index
    user = Custinfo.list(page: params[:page], per: params[:per])
    if user.count > 0
      render json: api_hash_for_list(user), status: :ok
    else
      render json: "", status: 404
    end
  end

  def show
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      render json: user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update
    # Janus3 고객DB에 존재하는 고객인 경우 L-Care 핸드폰번호만 Update
    # address 추가
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      if params[:phone].present?
        user.phone = params[:phone]
      end
      if params[:address].present?
        user.address = params[:address]
      end
      if user.save
        render json: user.to_api_hash, status: :ok
      else
        render json: "", status: 404
      end
    else
      render json: "", status: 404
    end
  end

  def measure_update
    # Data 분석이 완료 된 후 CUSTINFO의 분석횟수 카운트 증가시키고, 최근 분석일 Update
    user = Custinfo.where(custserial: params[:custserial]).first
    if !user.nil?
      user.increase_measureno
      user.update_lastanaldate
      user.save
      render json: user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :n_cust_id, :custname, :sex, :age, :birthyy, :birthmm, :birthdd, :phone, :uptdate, :shop_cd, :is_agree_privacy, :is_agree_after, :is_agree_marketing, :is_agree_thirdparty_info, :address)
  end
end
