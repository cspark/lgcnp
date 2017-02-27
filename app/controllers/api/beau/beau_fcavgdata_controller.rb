class Api::Beau::BeauFcavgdataController < Api::ApplicationController
  def index
    list = Fcavgdata.all.order("n_index asc").page(params[:page]).per(params[:per])
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render json: "", status: 404
    end
  end
end
