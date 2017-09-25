class Api::Fcadmin::FcadminUserController < Api::ApplicationController
  def index
    Rails.logger.info ""
    list = FcadminUser.list(admin_id: params[:admin_id])
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "FcadminUser is not exist!!!", status: 204
    end
  end

  def create
    fcadmin_user = FcadminUser.new(permitted_params)

    if fcadmin_user.save
      render json: fcadmin_user.to_api_hash, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def update
    # Janus3 고객DB에 존재하는 고객인 경우 L-Care 핸드폰번호만 Update
    # address 추가
    fcadmin_user = FcadminUser.where(admin_id: params[:id]).first
    if !fcadmin_user.nil?
      if params.has_key?(:encrypted_pw)
        fcadmin_user.encrypted_pw = params[:encrypted_pw]
      end
      if params.has_key?(:pw_uptdate)
        fcadmin_user.pw_uptdate = params[:pw_uptdate]
      end
      if params.has_key?(:last_login_date)
        fcadmin_user.last_login_date = params[:last_login_date]
      end

      if fcadmin_user.save
        render json: fcadmin_user.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render :text => "FcadminUser is not exist!!!", status: 204
    end
  end

  def destroy
    Rails.logger.info "destroy!!!"
    fcadmin_user = FcadminUser.where(admin_id: params[:id]).first
    if !fcadmin_user.nil?
      if fcadmin_user.delete
        render :text => "Delete Complete", status: 200
      else
        render :text => "Delete Fail", status: 404
      end
    else
      render :text => "FcadminUser is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:admin_id, :encrypted_pw, :pw_uptdate, :create_date, :last_login_date, :updated_at)
  end
end
