class Api::Admin::AdminFcshopController < Api::ApplicationController
  skip_before_action :authenticate, :only => [:get_api_key]
  
  def index
    # 매장 테이블 전체 조회 (* Next 조회 필요)
    if params.has_key?(:shop_cd)
      shop = Fcshop.where(shop_cd: params[:shop_cd]).first
      if !shop.nil?
        render json: shop.to_api_hash, status: :ok
      else
        render :text => "Shop not exist!!!", status: 204
      end
    else
      list = Fcshop.all.order("shop_cd asc")
      render json: api_hash_for_list(list), status: :ok
    end
  end

  def create
    if !Fcshop.where(shop_cd: params[:shop_cd]).first.nil?
      render :text => "Shop already exist!!!", status: 204
      return
    end

    fcshop = Fcshop.new(permitted_params)
    if fcshop.save
      render json: fcshop.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  private
  def permitted_params
    params.permit(:shop_cd, :shop_name, :ch_cd)
  end
end
