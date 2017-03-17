class Api::Admin::AdminFcshopController < Api::ApplicationController
  def index
    # 매장 테이블 전체 조회 (* Next 조회 필요)
    list = Fcshop.all.order("shop_cd asc")
    render json: api_hash_for_list(list), status: :ok
  end

  def create
    if !Fcshop.where(shop_cd: params[:shop_cd]).first.nil?
      render :body => "Shop already exist!!!", status: 204
      return
    end

    fcshop = Fcshop.new(permitted_params)
    if fcshop.save
      render json: fcshop.to_api_hash, status: :ok
    else
      render :body => "Fail!!!", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:shop_cd, :shop_name, :ch_cd)
  end
end
