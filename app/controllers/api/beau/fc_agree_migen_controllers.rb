class Api::Beau::FcAgreeMigenController < Api::ApplicationController
  def index
    agree_migen = FcAgreeMigen.where(custserial: params[:custserial]).first
    if agree_migen.present?
      render json: agree_migen.to_api_hash, status: :ok
    else
      render text: "FcAgreeMigen not found", status: 404
    end
  end

  def update
    agree_migen = FcAgreeMigen.where(custserial: params[:custserial]).first
    if agree_migen.update permitted_params
      render json: agree_migen.to_api_hash, status: :ok
    else
      render text: "FcAgreeMigen was not updated", status: 404
    end

  end

  def create
    agree_migen = FcAgreeMigen.new(permitted_params)
    if agree_migen.save
      render json: agree_migen.to_api_hash, status: :ok
    else
      render text: "FcAgreeMigen was not created", status: 404
    end
  end

  private
  def permitted_params
    params.permit(
      :custserial,
      :ch_cd,
      :shop_cd,
      :is_private,
      :private_agree_dt,
      :private_retract_dt,
      :is_consignment,
      :consignment_agree_dt,
      :consignment_retract_dt,
      :is_skin_residence,
      :skin_residence_agree_dt,
      :skin_residence_retract_dt,
      :is_sensitive,
      :sensitive_agree_dt,
      :sensitive_retract_dt,
      :is_private_third,
      :private_third_agree_dt,
      :private_third_retract_dt,
      :is_sensitive_third,
      :sensitive_third_agree_dt,
      :sensitive_third_retract_dt,
      :is_marketing,
      :marketing_agree_dt,
      :marketing_retract_dt
    )
  end
end
