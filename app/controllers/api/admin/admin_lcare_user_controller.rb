class Api::Admin::AdminLcareUserController < Api::ApplicationController
  def lcare_integrated_user_list
    # L-Care 통합회원 조회 이름, 생년월일, 핸드폰번호, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    if params.has_key?(:cust_hnm) && params.has_key?(:birth_year) && params.has_key?(:birth_mmdd)
      if params.has_key?(:cell_phnno)
        lcare_users = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], cell_phnno: params[:cell_phnno])
      else
        lcare_users = LcareUser.list(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd])
      end

      if lcare_users.count > 0
        render json: api_hash_for_list(lcare_users), status: :ok
      else
        render :text => "Lcare user not exist!!!", status: 204
      end
    else
      render :text => "Lcare user not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:cust_hnm, :birth_year, :birth_mmdd, :cell_phnno)
  end
end
