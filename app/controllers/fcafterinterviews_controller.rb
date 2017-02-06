class FcafterinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:show]
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


  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
