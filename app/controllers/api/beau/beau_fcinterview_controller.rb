class Api::Beau::BeauFcinterviewController < Api::ApplicationController
  skip_before_action :authenticate, :only => [:get_api_key]
  
  def show
    interview = Fcinterview.where(custserial: params[:id], measureno: params[:measureno]).first
    if !interview.nil?
      render json: interview.to_api_hash, status: :ok
    else
      render :text => "Fcinterview is not exist!!!", status: 204
    end
  end

  def create
    # Data 분석이 완료 된 후 해당 고객 설문값 Insert
    if !Fcinterview.where(custserial: params[:custserial], ch_cd: params[:ch_cd], measureno: params[:measureno]).first.nil?
      render :text => "Fcinterview exist!!!", status: 204
      return
    end
    fcinterview = Fcinterview.new(permitted_params)
    t = Time.now
    fcinterview.uptdate = t.to_s.split(" ")[0]

    if fcinterview.save
      render json: fcinterview.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :faceno, :measuredate, :measureno, :interview_1, :interview_2, :interview_3, :interview_4, :interview_5, :interview_6, :interview_7, :interview_8, :interview_9, :interview_10, :shop_cd)
  end
end
