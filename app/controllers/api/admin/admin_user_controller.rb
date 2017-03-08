class Api::Admin::AdminUserController < Api::ApplicationController
  def index
    # 고객정보를 조건으로 CUSTSERIAL 값 조회 (고객정보 삭제 시 , Janus 분석 data 조회 시 CUSTINFO update 시)
    user = Custinfo.where(custname: params[:custname], sex: params[:sex], birthyy: params[:birthyy], birthmm: params[:birthmm], birthdd: params[:birthdd], phone: params[:phone]).first
    if !user.nil?
      render :json => user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update
    # Janus3 고객DB에 존재하는 고객인 경우 L-Care 핸드폰번호만 Update
    # address 추가
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      if params.has_key?(:phone)
        user.phone = params[:phone]
      end
      if params.has_key?(:is_agree_after)
        user.is_agree_after = params[:is_agree_after]
      end
      if params.has_key?(:is_agree_marketing)
        user.is_agree_marketing = params[:is_agree_marketing]
      end
      if params.has_key?(:is_agree_thirdparty_info)
        user.is_agree_thirdparty_info = params[:is_agree_thirdparty_info]
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

  def destroy
    user_list = Custinfo.where(custserial: params[:id])
    Rails.logger.info "destroy"
    Rails.logger.info user_list
    if user_list.count > 0
      render json: api_hash_for_list(user_list), status: :ok
    else
      render json: "", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :n_cust_id, :custname, :sex, :age, :birthyy, :birthmm, :birthdd, :phone, :uptdate, :shop_cd, :is_agree_privacy, :is_agree_after, :is_agree_marketing, :is_agree_thirdparty_info, :address, :lastanaldate)
  end
end
