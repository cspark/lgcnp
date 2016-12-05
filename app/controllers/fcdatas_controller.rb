class FcdatasController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_action :verify_authenticity_token

  def index
    fcdatas = Fcdata.all
    render json: api_hash_for_list(fcdatas), status: :ok
  end

  def get_before_fcdata_count
    serial = params[:serial]

    face_datas_count = Fcdata.where(custserial: serial).count
    render :text => face_datas_count, status: 200
  end

  def check_yanus_status
    serial = params[:serial]
    before_count = params[:before_count]

    face_datas_count = Fcdata.where(custserial: serial).count
    # if before_count.to_i < face_datas_count.to_i
    #   render :text => face_data.status, status: 200
    # else
    #   render :text => "cannot check yanus status", status: 404
    # end

    #Test
    fcdata = Fcdata.all.first
    if fcdata.present?
      render json: fcdata.to_api_hash, status: 200
    else
      render json: "", status:404
    end    
  end

  def face_data
    serial = params[:serial]

    # face_data = Fcdata.where(custserial: serial).last
    face_data = Fcdata.all.last
    if face_data.present?
      render json: face_data.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
  end

  def face_data_existed
    serial = params[:serial]
    measureno = params[:measureno]

    # face_data = Fcdata.where(custserial: serial).where(measureno: measureno).last
    face_data = Fcdata.all.last
    if face_data.present?
      render json: face_data.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
  end

  def create
    fcdata = Fcdata.new(permitted_param)
    fcdata.save

    render :text => "create Complete", status: 200
  end

  def permitted_param
    permitted = params.permit(:custserial, :faceno, :measuredate, :measureno, :update, :mo_1, :mo_7, :mo_8, :pr_1, :pr_2, :pr_7, :PR_8, :PR_avr, :WR_3, :WR_4, :WR_5, :WR_6, :WR_avr,
    :EL_7, :EL_8, :EL_avr, :EL_angle_7, :EL_angle_8, :SB_1, :SB_2, :SB_7, :SB_8, :SB_avr, :PP_1, :PP_2, :PP_7, :PP_8, :PP_avr, :PP_Ratio_1, :PP_Ratio_2, :PP_Ratio_7, :PP_Ratio_8, :PP_Ratio_avr,
    :SP_PL_1, :SP_PL_2,	:SP_PL_3, :SP_PL_4, :SP_PL_5, :SP_PL_6, :SP_PL_7, :SP_PL_8, :SP_PL_avr, :SP_UV_1, :SP_UV_2, :SP_UV_3, :SP_UV_4, :SP_UV_5, :SP_UV_6, :SP_UV_7, :SP_UV_8, :SP_UV_avr,
    :SK_C_1, :SK_C_2, :SK_C_4, :SK_C_6, :SK_C_7,	:SK_C_8,	:SK_C_avr,	:SK_R_1,	:SK_R_2,	:SK_R_4,	:SK_R_6,	:SK_R_7, :SK_R_8, :SK_R_avr,	:SK_G_1,	:SK_G_2,	:SK_G_4, :SK_G_6,	:SK_G_7, :SK_G_8,	:SK_G_avr,
    :SK_B_1,	:SK_B_2,	:SK_B_4,	:SK_B_6,	:SK_B_7,	:SK_B_8,	:SK_B_avr,	:Lab_L, :Lab_a, :Lab_b, :COLORTYPE, :SUNTYPE, :SKINTYPE, :SCORE_R, :SCORE_L)
  end
end
