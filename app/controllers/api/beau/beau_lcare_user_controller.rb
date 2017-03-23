class Api::Beau::BeauLcareUserController < Api::ApplicationController
  def lcare_integrated_user_list
    # L-Care 통합회원 조회 이름, 생년월일, 핸드폰번호, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    if params.has_key?(:cell_phnno)
      lcare_users = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], cell_phnno: params[:cell_phnno])
    else
      lcare_users = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd])
    end

    if lcare_users.count > 0
      response.headers["Transfer-Encoding"] = "Closed"

      response_json = ActiveSupport::JSON.encode(api_hash_for_list(lcare_users))
      Rails.logger.info response_json
      response.set_header("Content-length", response_json.to_s.length)
      Rails.logger.info response_json.to_s.length
      Rails.logger.info response_json
      render text: response_json, status: :ok
    else
      render json: "", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:cust_hnm, :birth_year, :birth_mmdd, :cell_phnno)
  end
end
