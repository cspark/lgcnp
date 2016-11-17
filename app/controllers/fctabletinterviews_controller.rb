class FctabletinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_action :verify_authenticity_token

  def index
    tabletinterview = Fctabletinterview.all
    render json: api_hash_for_list(tabletinterview), status: :ok
  end

  def find_interviews
    serial = params[:custserial]
    tabletinterview = Fctabletinterview.where(custserial:serial).first
    if tabletinterview.present?
      render json: tabletinterview, status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    tabletinterview = Fctabletinterview.new(permitted_param)
    tabletinterview.save
  end

  def update_interviews
    serial = params[:CUSTSERIAL]
    existed_interview = Fctabletinterview.where(custserial: serial).first
    existed_interview.update(permitted_param)
  end

  def permitted_param
    permitted = params.permit(:CUSTSERIAL, :A_1,:A_2,:A_3,:B_1,:B_2,:B_3,:B_4,:C_1,:D_1,:D_2,:D_3,:D_4,:D_5,:D_6,:D_7,:D_8,:D_9,:D_10,
    :SKIN_TYPE,:SOLUTION_BEFORE_SOLUTION_1,:SOLUTION_AFTER_SOLUTION_1,:SOLUTION_BEFORE_SOLUTION_2,:SOLUTION_AFTER_SOLUTION_2,
    :SOLUTION_BEFORE_SERUM,:SOLUTION_AFTER_SERUM,:SOLUTION_BEFORE_AMPLE_1,:SOLUTION_AFTER_AMPLE_1,:SOLUTION_BEFORE_AMPLE_2,:SOLUTION_AFTER_AMPLE_2,
    :SOLUTION_BEFORE_READY_MADE_COSMETIC,:SOLUTION_AFTER_READY_MADE_COSMETIC)
  end
end
