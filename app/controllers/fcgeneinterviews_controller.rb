class FcgeneinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token,  :only => :create

  def create
    fcgeneinterview = FcgeneInterview.new(permitted_param)
    fcgeneinterview.uptdate = Time.now.strftime("%Y-%m-%d")

    if fcgeneinterview.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def permitted_param
    permitted = params.permit(:custserial, :gene_barcode, :ch_cd, :measureno, :shop_cd, :q1_height, :q1_weight, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :q11, :q12, :q13, :q14, :q15_nation, :q15_birth_nation)
  end
end
