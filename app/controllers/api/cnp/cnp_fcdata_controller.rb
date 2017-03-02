class Api::Cnp::CnpFcdataController < Api::ApplicationController
  def show
    list = BeauFcdata.list(custserial: params[:id])
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    # Data 분석이 완료 된 후 해당 고객 분석값 Insert
    if !BeauFcdata.where(custserial: params[:custserial], ch_cd: params[:ch_cd], measureno: params[:measureno]).first.nil?
      render json: "", status: 404
      return
    end
    fcdata = BeauFcdata.new(permitted_params)
    t = Time.now
    fcdata.uptdate = t.to_s.split(" ")[0]

    if fcdata.save
      render json: fcdata.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def destroy
    fcdata = BeauFcdata.where(custserial: params[:custserial], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
    if !fcdata.nil?
      if fcdata.delete
        render :text => "Delete Complete", status: 200
      else
        render json: "Delete Fail", status: 404
      end
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :faceno, :measuredate, :measureno, :mo_1, :mo_7, :mo_8, :pr_1, :pr_2, :pr_7, :pr_8, :pr_avr, :wr_3, :wr_4, :wr_5, :wr_6, :wr_avr, :el_7, :el_8, :el_avr, :el_angle_7, :el_angle_8, :sb_1, :sb_2, :sb_7, :sb_8, :sb_avr, :pp_1, :pp_2, :pp_7, :pp_8, :pp_avr, :pp_ratio_1, :pp_ratio_2, :pp_ratio_7, :pp_ratio_8, :pp_ratio_avr, :sp_pl_1, :sp_pl_2, :sp_pl_3, :sp_pl_4, :sp_pl_5, :sp_pl_6, :sp_pl_7, :sp_pl_8, :sp_pl_avr, :sp_uv_1, :sp_uv_2, :sp_uv_3, :sp_uv_4, :sp_uv_5, :sp_uv_6, :sp_uv_7, :sp_uv_8, :sp_uv_avr, :sk_c_1, :sk_c_2, :sk_c_4, :sk_c_6, :sk_c_7, :sk_c_8, :sk_c_avr, :sk_r_1, :sk_r_2, :sk_r_4, :sk_r_6, :sk_r_7, :sk_r_8, :sk_r_avr, :sk_g_1, :sk_g_2, :sk_g_4, :sk_g_6, :sk_g_7, :sk_g_8, :sk_g_avr, :sk_b_1, :sk_b_2, :sk_b_4, :sk_b_6, :sk_b_7, :sk_b_8, :sk_b_avr, :lab_l, :lab_a, :lab_b, :colortype, :suntype, :skintype, :score_r, :score_l, :e_sebum_t, :e_sebum_u, :e_porphyrin_t, :e_porphyrin_u, :skintype, :janus_status, :shop_cd, :worry_skin_1, :worry_skin_2, :m_skintype)
  end
end
