class Api::Beau::BeauFcinterviewController < Api::ApplicationController
  def show
    interview = Fcinterview.where(custserial: params[:id], measureno: params[:measureno]).first
    if !interview.nil?
      render json: interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    # Data 분석이 완료 된 후 해당 고객 설문값 Insert
    fcinterview = Fcinterview.new(permitted_params)
    t = Time.now
    fcinterview.uptdate = t.to_s.split(" ")[0]

    if fcinterview.save
      render json: fcinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :faceno, :measuredate, :measureno, :interview_1, :interview_2, :interview_3, :interview_4, :interview_5, :interview_6, :interview_7, :interview_8, :interview_9, :interview_10, :shop_cd)
  end
end
