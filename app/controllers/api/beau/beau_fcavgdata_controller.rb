class Api::Beau::BeauFcavgdataController < Api::ApplicationController
  def index
    if params.has_key?(:his_date)
      his_date = params[:his_date].to_date
      list = FcavgdataHistory.where("? BETWEEN to_date(his_start_date) AND to_date(his_end_date)", his_date).order("n_index asc")
      if list.count > 0
        render json: api_hash_for_list(list), status: :ok
      else
        list = Fcavgdata.all.order("n_index asc")
        if list.count > 0
          render json: api_hash_for_list(list), status: :ok
        else
          render :text => "Fcavgdata is not exist!!!", status: 204
        end
      end
    else
      list = Fcavgdata.all.order("n_index asc")
      if list.count > 0
        render json: api_hash_for_list(list), status: :ok
      else
        render :text => "Fcavgdata is not exist!!!", status: 204
      end
    end
  end
end
