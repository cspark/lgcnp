class FcpossController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def index
    fcpos = Fcpos.all
    render json: api_hash_for_list(fcpos), status: :ok
  end

  def face_pos
    serial = params[:custserial]

    face_pos = Fcpos.where(custserial: serial).first
    if face_pos.present?
      render json: face_pos.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
  end

  def create
    fcpos = Fcpos.new(permitted_param)
    fcpos.save

    render :text => "face position data saved", status: 200
  end

  def update
    fcpos = Fcpos.find_by(custserial: params[:custserial], mesasureno: params[:measureno])
    if fcpos.update permitted_param
      render text: "saved", status: 200
    else
      render text: "not saved"
    end
  end

  def permitted_param
    params.permit(:CUSTSERIAL,:FACENO, :MEASUREDATE, :MEASURENO, :UPTDATE, :FH_X, :FH_Y, :FH_W , :FH_H,
    :NS_X,	:NS_Y ,	:NS_W,	:NS_H,	:RES_X, :RES_Y,	:RES_W,	:RES_H,	:REU_X,	:REU_Y,	:REU_W,	:REU_H,	:LES_X,	:LES_Y,
    :LES_W ,	:LES_H,	:LEU_X,	:LEU_Y, :LEU_W, :LEU_H, :RS_X, :RS_Y, :RS_W, :RS_H, :LS_X, :LS_Y, :LS_W, :LS_H,	:RT_RE_L,
    :RT_RE_T, :RT_RE_R,	:RT_RE_B,	:RT_LE_L,	:RT_LE_T,	:RT_LE_R, :RT_LE_B , :RT_LIP_L, :RT_LIP_T, :RT_LIP_R,
    :RT_LIP_B, :RT_RES_X, :RT_RES_Y,	:RT_LES_X, :RT_LES_Y,:RT_FACE_L,:RT_FACE_T,:RT_FACE_R,:RT_FACE_B)
  end
end
