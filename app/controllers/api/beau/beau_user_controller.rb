class Api::Beau::BeauUserController < Api::ApplicationController
  def index
    user = Custinfo.list(page: params[:page], per: params[:per])
    if user.count > 0
      render json: api_hash_for_list(user), status: :ok
    else
      render json: "", status: 404
    end
  end

  def lcare_user_list
    # user = Custinfo.list(page: params[:page], per: params[:per], n_cust_id: params[:n_cust_id])
    # L-Care Serial 조건으로 Janus3 DB에 해당 L-Care 회원이 존재하는지 확인
    user = Custinfo.where(n_cust_id: params[:n_cust_id]).first
    if !user.nil?
      render json: user.to_api_hash, status: :ok
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

  def create
    # 고객정보를 insert 하기 위하여 Max(CUSTSERIAL) 값을 구하여 +1
    # L-care 조회하여 받은 회원 정보로 janus3 회원정보 insert

    user = Custinfo.new(permitted_params)
    if Custinfo.all.count > 0
      custserial = Custinfo.all.order('CAST(custserial AS INT) desc').first.custserial.to_i + 1
    else
      custserial = 1.to_s
    end
      user.custserial = custserial.to_s

    t = Time.now
    yymmdd = t.to_s.split(" ")[0]
    user.uptdate = yymmdd.split("-")[0] +"/"+ yymmdd.split("-")[1] +"/"+ yymmdd.split("-")[2]

    if user.save
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
