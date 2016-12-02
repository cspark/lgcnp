class FctabletinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_action :verify_authenticity_token

  def index
    tabletinterview = Fctabletinterview.all
    render json: api_hash_for_list(tabletinterview), status: :ok
  end

  def find_interviews
    serial = params[:custserial]
    tabletinterview = Fctabletinterview.where(custserial: serial).first
    if tabletinterview.present?
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    tabletinterview = Fctabletinterview.new(permitted_param)
    tabletinterview.tablet_interview_id = Fctabletinterview.all.count
    t = Time.now
    tabletinterview.uptdate = t.strftime("%Y-%m-%d-%H-%m")

    if tabletinterview.save
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update_interviews
    Rails.logger.info params[:tablet_interview_id]
    existed_interview = Fctabletinterview.where(tablet_interview_id: params[:tablet_interview_id]).last
    if existed_interview.update(permitted_param)
      render json: existed_interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end

  end

  def permitted_param
    permitted = params.permit(:custserial, :tablet_interview_id, :a_1,:a_2,:a_3,:b_1,:b_2,:b_3,:b_4,:c_1,:d_1,:d_2,:d_3,:d_4,:d_5,:d_6,:d_7,:d_8,:d_9,:d_10,
    :skin_type,:before_solution_1,:after_solution_1,:before_solution_2,:after_solution_2,
    :before_serum,:after_serum,:before_ample_1,:after_ample_1,:before_ample_2,:after_ample_2,
    :before_made_cosmetic,:after_made_cosmetic,:ch_cd)
  end
end
