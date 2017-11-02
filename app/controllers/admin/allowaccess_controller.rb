class Admin::AllowaccessController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    @range = Allowaccess.all
  end

  def create
    range = Allowaccess.new(permitted_params)

    if range.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def edit_access_range
    @range = Allowaccess.where(low_ip: params[:low_ip], high_ip: params[:high_ip]).first
  end

  def update
    range = Allowaccess.where(low_ip: params[:init_low_ip], high_ip: params[:init_high_ip]).first
    range.low_ip = params[:low_ip]
    range.high_ip = params[:high_ip]

    if range.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def delete
    range = Allowaccess.where(low_ip: params[:low_ip], high_ip: params[:high_ip]).first
    if range.delete
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def permitted_params
    params.permit(:low_ip, :high_ip)
  end
end
