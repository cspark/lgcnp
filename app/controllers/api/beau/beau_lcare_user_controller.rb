class Api::Beau::BeauLcareUserController < Api::ApplicationController
  def lcare_integrated_user_list_at_least
    # L-Care 통합회원 조회 이름, 생년월일, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    Rails.logger.info "lcare_integrated_user_list_at_least!!!"
    lcare_user = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], page: params[:page], per: params[:per])
    if lcare_user.count > 0
      render json: api_hash_for_list(user), status: :ok
    else
      render json: "", status: 404
    end
  end

  def lcare_integrated_user_list
    # L-Care 통합회원 조회 이름, 생년월일, 핸드폰번호, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    Rails.logger.info "lcare_integrated_user_list!!!"
    lcare_user = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], cell_phnno: params[:cell_phnno] ,page: params[:page], per: params[:per])
    if lcare_user.count > 0
      render json: api_hash_for_list(user), status: :ok
    else
      render json: "", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:cust_hnm, :birth_year, :birth_mmdd, :cell_phnno, :page, :per)
  end
end
