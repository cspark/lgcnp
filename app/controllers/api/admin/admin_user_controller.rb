class Api::Admin::AdminUserController < Api::ApplicationController
  def index
    # 고객정보를 조건으로 CUSTSERIAL 값 조회 (고객정보 삭제 시 , Janus 분석 data 조회 시 CUSTINFO update 시)
    user = Custinfo.where(custname: params[:custname], sex: params[:sex], birthyy: params[:birthyy], birthmm: params[:birthmm], birthdd: params[:birthdd], phone: params[:phone]).first
    if !user.nil?
      render :json => user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update
    # Janus3 고객DB에 존재하는 고객인 경우 L-Care 핸드폰번호만 Update
    # address 추가
    user = Custinfo.where(custserial: params[:id]).first
    if !user.nil?
      if params.has_key?(:phone)
        user.phone = params[:phone]
      end
      if params.has_key?(:is_agree_after)
        user.is_agree_after = params[:is_agree_after]
      end
      if params.has_key?(:is_agree_marketing)
        user.is_agree_marketing = params[:is_agree_marketing]
      end
      if params.has_key?(:is_agree_thirdparty_info)
        user.is_agree_thirdparty_info = params[:is_agree_thirdparty_info]
      end

      if user.save
        render json: user.to_api_hash, status: :ok
      else
        render json: "", status: 404
      end
    else
      render json: "", status: 404
    end
  end

  def destroy
    user = Custinfo.where(custserial: params[:id]).first
    Rails.logger.info "destroy"
    Rails.logger.info user_list

    measureno = user_list.order("measureno desc").first.measureno
    image_remove(serial: user.custserial, measureno: measureno)

    render json: user.to_api_hash, status: :ok
  end

  def image_remove(serial: nil, measureno: nil)
    #이미지 삭제하기
    Rails.logger.info serial
    user = Custinfo.where(custserial: serial).first
    sub_folder_name = (((user.custserial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"
    Rails.logger.info sub_folder_name

    ftp_path = ""
    if !user.ch_cd.nil?
      ftp_path = "ftp://165.244.88.27/"
      ftp_path << user.ch_cd.to_s
      ftp_path << "/"
    else
      ftp_path = "ftp://165.244.88.27/CNP/"
    end

    (1..measureno).each do |num|
      ftp_path << sub_folder_name.to_s

      ftp_path << "/"
      ftp_path << user.custserial.to_i.to_s
      ftp_path << "-"
      ftp_path << num.to_i.to_s

      Rails.logger.info ftp_path
      system("echo FILE Delete")
      file_delete_command = "wget --user janus --password pielgahn2012#1 --method=DELETE"
      file_delete_command << ftp_path
      file_delete_command << " -N -P "

      file_delete_command << sub_folder_name
      file_delete_command << "/"
      file_delete_command << user.custserial.to_i.to_s
      file_delete_command << "-"
      file_delete_command << measureno.to_i.to_s
      Rails.logger.info "final"
      Rails.logger.info file_delete_command
      system(file_delete_command)

      rm_rf_command = "rm -rf "
      if !user.ch_cd.nil?
        rm_rf_command << "public/"
        rm_rf_command << user.ch_cd.to_s
        rm_rf_command << "/"
      else
        rm_rf_command << "public/CNP/"
      end

      Rails.logger.info rm_rf_command

      rm_rf_command << sub_folder_name

      rm_rf_command << "/"
      rm_rf_command << user.custserial.to_i.to_s
      rm_rf_command << "-"
      rm_rf_command << measureno.to_i.to_s
      Rails.logger.info rm_rf_command
      system(rm_rf_command)
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :n_cust_id, :custname, :sex, :age, :birthyy, :birthmm, :birthdd, :phone, :uptdate, :shop_cd, :is_agree_privacy, :is_agree_after, :is_agree_marketing, :is_agree_thirdparty_info, :address, :lastanaldate)
  end
end
