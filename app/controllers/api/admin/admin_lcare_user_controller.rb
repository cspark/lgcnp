class Api::Admin::AdminLcareUserController < Api::ApplicationController
  def lcare_integrated_user_list
    # L-Care 통합회원 조회 이름, 생년월일, 핸드폰번호, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    lcare_user = LcareUser.where(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], cell_phnno: params[:cell_phnno]).first
    if !lcare_user.nil?
      response.set_header("Content-length", ActiveSupport::JSON.encode(lcare_user.to_api_hash).size)
      render json: lcare_user.to_api_hash, status: :ok
    else
      render :text => "LcareUser is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:cust_hnm, :birth_year, :birth_mmdd, :cell_phnno)
  end
end
