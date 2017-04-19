class Api::Beau::BeauFcavgdataController < Api::ApplicationController
  skip_before_action :authenticate, :only => [:get_api_key]
  
  def index
    list = Fcavgdata.all.order("n_index asc")
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "Fcavgdata is not exist!!!", status: 204
    end
  end
end
