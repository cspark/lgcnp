class FcafterinterviewsController < AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def show
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]

    @after_interview = Fcafterinterview.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).first
  end

  def show_1
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]

    @after_interview = Fcafterinterview.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).first
    render 'show_1'
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

    if params.has_key?(:a4)
      after_interview.a4 = params[:a4]
    end

    after_interview.a5 = params[:a5]

    if params.has_key?(:a1_1)
      after_interview.a1_1 = params[:a1_1]
    end
    after_interview.save
  end
end
