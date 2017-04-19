class Api::Cnp::CnpFcposController < Api::ApplicationController
  skip_before_action :authenticate, :only => [:get_api_key]
  
  def create
    # Data 분석이 완료 된 후 해당 고객 설문값 Insert
    if !Fcpos.where(custserial: params[:custserial], ch_cd: params[:ch_cd], measureno: params[:measureno]).first.nil?
      render :text => "Fcpos already exist!!!", status: 204
      return
    end
    fcpos = Fcpos.new(permitted_params)
    t = Time.now
    fcpos.uptdate = t.to_s.split(" ")[0]

    if fcpos.save
      render json: fcpos.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def destroy
    fcpos = Fcpos.where(custserial: params[:id], ch_cd: params[:ch_cd], measureno: params[:measureno])
    if fcpos.count > 0
      if fcpos.delete_all
        render :text => "Delete Complete", status: 200
      else
        render :text => "Delete Fail", status: 404
      end
    else
      render :text => "Fcpos is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :faceno, :measuredate, :measureno, :fh_x, :fh_y, :fh_w, :fh_h, :ns_x, :ns_y, :ns_w, :ns_h, :res_x, :res_y, :res_w, :res_h, :reu_x, :reu_y, :reu_w, :reu_h, :les_x, :les_y, :les_w, :les_h, :leu_x, :leu_y, :leu_w, :leu_h, :rs_x, :rs_y, :rs_w, :rs_h, :ls_x, :ls_y, :ls_w, :ls_h, :rt_re_l, :rt_re_t, :rt_re_r, :rt_re_b, :rt_le_l, :rt_le_t, :rt_le_r, :rt_le_b, :rt_lip_l, :rt_lip_t, :rt_lip_r, :rt_lip_b, :rt_res_x, :rt_res_y, :rt_les_x, :rt_les_y, :shop_cd)
  end
end
