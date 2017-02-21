class Api::Beau::UserController < Api::ApplicationController
  def index
    # user = Custinfo.list(page: params[:page], per: params[:per], n_cust_id: params[:n_cust_id])
    # L-Care Serial 조건으로 Janus3 DB에 해당 L-Care 회원이 존재하는지 확인
    user = Custinfo.where(n_cust_id: params[:n_cust_id]).first
    render json: user.to_api_hash
  end

  def show
    user = Custinfo.where(custserial: params[:custserial]).first
    render json: user.to_api_hash
  end

  def create
    # 고객정보를 insert 하기 위하여 Max(CUSTSERIAL) 값을 구하여 +1
    user = Custinfo.new(permitted_params)
    custserial = Custinfo.all.order('custserial desc').first.custserial.to_i + 1
    user.custserial = custserial.to_s
    user.save
    render json: user.to_api_hash
  end

  def integrated_create
    # L-care 조회하여 받은 회원 정보로 janus3 회원정보 insert
    user = Custinfo.new(permitted_params)
    user.save
    render json: user.to_api_hash
  end

  def update
    # Janus3 고객DB에 존재하는 고객인 경우 L-Care 핸드폰번호만 Update
    user = Custinfo.where(custserial: params[:custserial]).first
    if user.count > 0
      user.phone = params[:phone]
      user.save
      render json: user.to_api_hash
    else
      render_error(errors: user.errors.full_messages)
    end
  end

  def measure_update
    # Data 분석이 완료 된 후 CUSTINFO의 분석횟수 카운트 증가시키고, 최근 분석일 Update
    user = Custinfo.where(custserial: params[:custserial]).first
    user.measureno = user.measureno.to_i + 1
    user.measureno = user.measureno.to_s

    yymmdd = Time.now.to_s.split(" ")[0]
    temp_date = Time.now.to_s.split(" ")[1]
    hhmmss = temp_date.split(":")[0] + "-" +temp_date.split(":")[1]+ "-" +temp_date.split(":")[2]
    user.lastanaldate = yymmdd+ "-" +hhmmss

    user.save
    render json: user.to_api_hash
  end

  private
  def permitted_params
    params.permit(:n_cust_id, :custserial, :ch_cd, :n_cust_id, :custname, :sex, :birthyy, :birthmm, :birthdd, :phone, :uptdate, :shop_cd)
  end
end
