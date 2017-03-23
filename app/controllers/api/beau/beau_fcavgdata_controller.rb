class Api::Beau::BeauFcavgdataController < Api::ApplicationController
  def index
    list = Fcavgdata.all.order("n_index asc")
    if list.count > 0
      response.set_header("Content-length", ActiveSupport::JSON.encode(api_hash_for_list(list)).size)
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "Fcavgdata is not exist!!!", status: 204
    end
  end
end
