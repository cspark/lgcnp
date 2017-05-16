class Api::Cnp::CnpUserController < Api::ApplicationController
  def index
    # CNP Tablet 앱에서 가입한 고객정보를 조건으로 고객정보 조회 (* Next 조회 필요) *추가 ADDRESS 필드
    if !params[:birthmm].nil? && params[:birthmm].length == 1
      birthmm = "0".concat(params[:birthmm])
    else
      birthmm = params[:birthmm]
    end
    if !params[:birthdd].nil? && params[:birthdd].length == 1
      birthdd = "0".concat(params[:birthdd])
    else
      birthdd = params[:birthdd]
    end

    username = URI.decode(params[:custname])
    if params.has_key?(:phone)
      if params.has_key?(:ch_cd) && params[:ch_cd] == "CNPR"
        user = Custinfo.where.not(ch_cd: "CNP").where(custname: params[:custname], birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, phone: params[:phone]).order("UPTDATE asc").first
      else
        user = Custinfo.where(custname: params[:custname], birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, phone: params[:phone]).order("UPTDATE asc").first
      end
    else
      if params[:ch_cd] == "CNPR"
        user = Custinfo.where.not(ch_cd: "CNP").where(custname: params[:custname], birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, ch_cd: params[:ch_cd]).order("UPTDATE asc").first
      else
        user = Custinfo.where(custname: params[:custname], birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, ch_cd: params[:ch_cd]).order("UPTDATE asc").first
      end
    end

    if !user.nil?
      render json: user.to_api_hash_for_yanus, status: :ok
    else
      render :text => "Custinfo is not exist!!!", status: 204
    end
  end

  def show
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      render json: user.to_api_hash_for_yanus, status: :ok
    else
      render :text => "Custinfo is not exist!!!", status: 404
    end
  end

  def update
    # CNP Tablet 앱에서 가입한 고객정보에서 거주지역(Address) Update
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      if params[:address].present?
        user.address = params[:address]
      end
      if user.save
        render json: user.to_api_hash_for_yanus, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render :text => "Custinfo is not exist!!!", status: 404
    end
  end


  def measure_update
    # Data 분석이 완료 된 후 CUSTINFO의 분석횟수 카운트 증가시키고, 최근 분석일 Update
    user = Custinfo.where(custserial: params[:custserial]).first
    if !user.nil?
      user.increase_measureno
      user.update_lastanaldate
      if user.save
        render json: user.to_api_hash_for_min, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render :text => "Custinfo is not exist!!!", status: 404
    end
  end

  def lcare_user_list
    user = Custinfo.where(n_cust_id: params[:n_cust_id]).where(ch_cd: params[:ch_cd]).first
    if !user.nil?
      render json: user.to_api_hash_for_yanus, status: :ok
    else
      render :text => "Custinfo is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :n_cust_id, :custname, :sex, :age, :birthyy, :birthmm, :birthdd, :phone, :uptdate, :shop_cd, :is_agree_privacy, :is_agree_after, :is_agree_marketing, :is_agree_thirdparty_info, :address, :lastanaldate, :measureno, :email)
  end
end
