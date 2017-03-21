class Api::Tablet::Cnprx::FcinterviewsController < Api::ApplicationController
  skip_before_filter :verify_authenticity_token,  :only => :create

  def index
    fcinterviews = Fcinterview.all
    render json: api_hash_for_list(fcinterviews),  status: :ok
  end

  def face_info
    serial = params[:custserial]

    face_info = Fcinterview.where(custserial: serial).first
    if face_info.present?
      render json: face_info.to_api_hash,  status: 200
    else
      render json: "",  status: 404
    end
  end

  def create
    fcinterview = Fcinterview.new(permitted_param)
    fcinterview.save

    render :text => "interview data saved"
  end

  def permitted_param
    permitted = params.permit( :CUSTSERIAL, :FACENO, :MEASUREDATE, :MEASURENO, :UPTDATE, :INTERVIEW_1, :INTERVIEW_2, :INTERVIEW_3, :INTERVIEW_4, :INTERVIEW_5, :INTERVIEW_6, :INTERVIEW_7, :INTERVIEW_8)
  end
end
