class Api::Beau::BeauController < ApplicationController
  def index
    # list = Custinfo.list(page: params[:page], per: params[:per], n_cust_id: params[:n_cust_id])
  end

  def show

  end

  def create

  end

  def update

  end

  private
  def permitted_params
    params.permit(:n_cust_id)
  end
end
