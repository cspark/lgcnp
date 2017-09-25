class Api::Admin::AdminUserController < Api::ApplicationController
  def index
    # 고객정보를 조건으로 CUSTSERIAL 값 조회 (고객정보 삭제 시 , Janus 분석 data 조회 시 CUSTINFO update 시)
    if !params[:birthmm].nil? && params[:birthmm].length == 1
      birthmm = "0".concat(params[:birthmm])
    else
      birthmm = params[:birthmm]
    end
    if !params[:birthdd].nil? && params[:birthdd].length == 1
      birthdd = "0".concat(params[:birthdd])
    else
      birthdd = params[:birthdd]
    end

    user = Custinfo.where(custname: params[:custname], sex: params[:sex], birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, phone: params[:phone]).first
    if !user.nil?
      render :json => user.to_api_hash_for_yanus, status: :ok
    else
      render :text => "Custinfo is not exist!!!", status: 204
    end
  end

  def user_list
    # Custinfo 테이블에서 고객이름,생년월일,핸드폰,성별 파라미터로 고객 조회
    if !params[:birthmm].nil? && params[:birthmm].length == 1
      birthmm = "0".concat(params[:birthmm])
    else
      birthmm = params[:birthmm]
    end
    if !params[:birthdd].nil? && params[:birthdd].length == 1
      birthdd = "0".concat(params[:birthdd])
    else
      birthdd = params[:birthdd]
    end

    custname = nil
    if params.has_key?(:custname)
      custname = URI.encode(params[:custname])
    end

    list = Custinfo.list(custname: custname, birthyy: params[:birthyy], birthmm: birthmm, birthdd: birthdd, phone: params[:phone])
    if list.count > 0
      render json: api_hash_for_user_list(list), status: :ok
    else
      render :text => "Custinfo is not exist!!!", status: 204
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
      if params.has_key?(:is_agree_privacy_residence)
        user.is_agree_privacy_residence = params[:is_agree_privacy_residence]
      end
      if params.has_key?(:address)
        user.address = params[:address]
      end
      if params.has_key?(:phone)
        user.phone = params[:phone]
      end

      if user.save
        render json: user.to_api_hash_for_yanus, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render :text => "Custinfo is not exist!!!", status: 204
    end
  end

  def destroy
    Rails.logger.info "destroy!!!"
    serial = params[:id]

    measureno = 0
    user_list = Custinfo.where(custserial: serial)
    Rails.logger.info user_list.count
    if user_list.count > 0
      if user_list.count > 0 && Rails.env.production? || Rails.env.staging?
        fcdata_list = Fcdata.where(custserial: serial)
        Rails.logger.info fcdata_list.count
        fcdata_list.each do |fcdata|
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_Sym_L_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_Sym_L_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_Sym_L_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_Sym_L_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_Sym_R_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_Sym_R_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_Sym_R_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_Sym_R_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_UV_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_UV_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_UV_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_UV_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_WH_PWC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_WH_PWC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_WH_PWC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_WH_PWC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_WH_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_WH_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_WH_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_WH_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_UVGR_SBC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_UVGR_SBC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_UVGR_SBC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_UVGR_SBC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_UV_GR_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_UV_GR_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_UV_GR_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_UV_GR_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_PL_PLC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_PL_PLC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_PL_PLC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_PL_PLC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_UVGR_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_UVGR_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_UVGR_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_UVGR_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_PL_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_PL_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_PL_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_PL_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "1", type: "_F_FM_PL_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "2", type: "_F_FM_PL_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "3", type: "_F_FM_PL_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: "4", type: "_F_FM_PL_UVC_",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_F_FM_WH_PWC_W",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_F_FM_WH_E",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_Sp_Pore_Cust",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_Sp_Spot_Cust",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_Sp_Wr_Cust",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_F_PW_SK_L_SIDE",  ch_cd: fcdata.ch_cd)
          image_remove(serial: fcdata.serial, measureno: fcdata.measureno.to_s, number: nil, type: "_END",  ch_cd: fcdata.ch_cd)
        end
      end
      # serial = "839"
      if user_list.count > 0
        Fctabletinterview.where(custserial: serial).delete_all
        Fctabletinterviewrx.where(custserial: serial).delete_all
        Fcafterinterview.where(custserial: serial).delete_all
        Fcdata.where(custserial: serial).delete_all
        Fcpos.where(custserial: serial).delete_all
        Fcinterview.where(custserial: serial).delete_all
        FcgeneInterview.where(custserial: serial).delete_all
        user_list.delete_all
      end

      if user_list.count == 0
        render :text => "Delete Success!!!", status: 200
      else
        render :text => "Delete Fail!!!", status: 404
      end
    else
      render :text => "Custinfo is not exist!!!", status: 204
    end
  end

  def image_remove(serial: nil, measureno: nil, number: nil, type: nil, ch_cd: nil)
    #이미지 삭제하기
    Rails.logger.info serial
    # serial = "839"
    # measureno = "1"
    # number = "1"
    # type = "_Sym_L_"
    sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"
    Rails.logger.info sub_folder_name

    ftp_path = ""
    if !ch_cd.nil?
      ftp_path = "'ftp://165.244.88.27/"
      ftp_path << ch_cd.to_s
      ftp_path << "/"
    else
      ftp_path = "'ftp://165.244.88.27/CNP/'"
    end

    ftp_path_delete_folder = ""

    ftp_path << sub_folder_name.to_s
    ftp_path_delete_folder << ftp_path
    ftp_path << "/"
    ftp_path << serial.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << "/'"

    delete_file = ""
    delete_file << serial.to_i.to_s
    delete_file << "-"
    delete_file << measureno.to_i.to_s
    delete_file << type
    delete_file << number if !number.nil?
    delete_file << ".jpg"

    Rails.logger.info ftp_path
    system("echo FILE Delete")
    file_delete_command = "curl -p --insecure "
    file_delete_command << ftp_path
    file_delete_command << " -u 'janus:pielgahn2012#1' -Q '-DELE "
    file_delete_command << delete_file
    file_delete_command << "' --ftp-create-dirs"

    # file_delete_command = "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -Q '-DELE 839-1_Sym_L_1.jpg' --ftp-create-dirs"
    # folder_delete_command = "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1' -u 'janus:pielgahn2012#1' -Q '-RMD 839-1' --ftp-create-dirs"
    Rails.logger.info file_delete_command
    system(file_delete_command)
    if type == "_END"
      folder_delete_command = "curl -p --insecure "
      folder_delete_command << ftp_path_delete_folder + "/'"
      folder_delete_command << " -u 'janus:pielgahn2012#1' -Q '-RMD "
      folder_delete_command << serial.to_i.to_s+ "-" +measureno.to_i.to_s
      folder_delete_command << "' --ftp-create-dirs"
      Rails.logger.info folder_delete_command
      system(folder_delete_command)

      rm_rf_command = "rm -rf "
      if !ch_cd.nil?
        rm_rf_command << "public/"
        rm_rf_command << ch_cd.to_s
        rm_rf_command << "/"
      else
        rm_rf_command << "public/CNP/"
      end

      Rails.logger.info rm_rf_command

      rm_rf_command << sub_folder_name
      rm_rf_command << "/"
      rm_rf_command << serial.to_s
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
