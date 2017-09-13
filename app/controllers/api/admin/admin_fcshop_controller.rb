class Api::Admin::AdminFcshopController < Api::ApplicationController
  def index
    # 매장 테이블 전체 조회 (* Next 조회 필요)
    if params.has_key?(:shop_cd) || params.has_key?(:shop_name) || params.has_key?(:ch_cd) || params.has_key?(:tel_no) || params.has_key?(:address)
      shop = Fcshop.list(shop_cd: params[:shop_cd], shop_name: params[:shop_name], ch_cd: params[:ch_cd], tel_no: params[:tel_no], address: params[:address]).first
      if !shop.nil?
        render json: shop.to_api_hash, status: :ok
      else
        render :text => "Shop is not exist!!! !!!", status: 404
      end
    else
      list = Fcshop.list(shop_cd: params[:shop_cd], shop_name: params[:shop_name], ch_cd: params[:ch_cd], tel_no: params[:tel_no], address: params[:address]).order('shop_cd DESC')
      if list.count > 0
        render json: api_hash_for_list(list), status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
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

  def update
    if params.has_key?(:id)
      shop = Fcshop.where(shop_cd: params[:id]).first
      if !shop.nil?
        if params.has_key?(:shop_name)
          shop.shop_name = params[:shop_name]
        end

        if params.has_key?(:tel_no)
          shop.tel_no = params[:tel_no]
        end

        if params.has_key?(:address)
          shop.address = params[:address]
        end

        if params.has_key?(:version_name)
          shop.version_name = params[:version_name]
        end

        if shop.save
          render json: shop.to_api_hash, status: :ok
        else
          render :text => "Fail!!!", status: 404
        end
      else
        render :text => "Fcshop is not exist!!!", status: 204
      end
    end
  end

  private
  def permitted_params
    params.permit(:shop_cd, :shop_name, :ch_cd, :tel_no, :address, :version_name)
  end
end
