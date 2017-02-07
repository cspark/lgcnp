class FcafterinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:show, :update]
  before_action :is_admin

  def show
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]

    @after_interview = Fcafterinterview.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).first
  end

  def update
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]
    order = params[:order]

    Rails.logger.info "!! Update "
    Rails.logger.info custserial
    Rails.logger.info tablet_interview_id
    Rails.logger.info after_interview_id
    after_interview = Fcafterinterview.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).where(order: order).first

    Rails.logger.info Fcafterinterview.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).where(order: order).count

    after_interview.a1 = params[:a1]
    after_interview.a2 = params[:a2]
    after_interview.a3 = params[:a3]
    after_interview.a4 = params[:a4]
    after_interview.a5 = params[:a5]
    after_interview.save
  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
