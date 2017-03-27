class Api::Beau::BeauFcmodecntController < Api::ApplicationController
  def index
    list = Fcmodecnt.list(shop_cd: params[:shop_cd], ch_cd: params[:ch_cd], mode_name: params[:mode_name], analdate: params[:analdate])
    if !list.nil?
      if list.count > 0
        render :json => { count: list.count }, status: 200
      else
        render :text => "Fcmodecnt not exist!!!",, status: 204
      end
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def create
    modecnt = Fcmodecnt.new(permitted_params)
    if Fcmodecnt.all.count > 0
      serial = Fcmodecnt.all.order('CAST(modecnt_serial AS INT) desc').first.modecnt_serial.to_i + 1
    else
      serial = 1.to_s
    end
      modecnt.modecnt_serial = serial.to_s

    t = Time.now
    yymmdd = t.to_s.split(" ")[0]
    modecnt.analdate = yymmdd +"-"+ t.to_s.split(" ")[1].split(":")[0] +"-"+ t.to_s.split(" ")[1].split(":")[1]

    if modecnt.save
      render json: modecnt.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  private
  def permitted_params
    permitted = params.permit(:modecnt_serial, :shop_cd, :ch_cd, :analdate, :mode_name)
  end
end
