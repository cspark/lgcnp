class ImagesController < Api::ApplicationController
  def create
    # 폴더 만들기
    custserial = params[:custserial]
    ch_cd = params[:ch_cd]
    measureno = params[:measureno]
    number = params[:number]
    type = params[:type]

    custserial = "839"
    ch_cd = "CNP"
    measureno = 1
    number = "1"
    type = "Sym_L_"

    user = Custinfo.where(custserial: custserial).first
    sub_folder_name = (((user.custserial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"

    make_dir_command = "mkdir "
    if !user.ch_cd.nil?
      make_dir_command << "public/"
      make_dir_command << user.ch_cd.to_s
      make_dir_command << "/"
    else
      make_dir_command << "public/CNP/"
    end

    # system(make_dir_command)

    make_dir_command << sub_folder_name
    # system(make_dir_command)

    make_dir_command << "/"
    make_dir_command << user.custserial.to_i.to_s
    make_dir_command << "-"
    make_dir_command << measureno.to_i.to_s
    # system(make_dir_command)
    # 업로드 하기 전 WAS 폴더 만들기
    # Success!!!!

    # ======================================
    # 이미지 WAS 서버 업로드
    private_folder_name = ""
    private_folder_name << user.custserial.to_i.to_s
    private_folder_name << "-"
    private_folder_name << measureno.to_i.to_s

    file_name = ""
    file_name << private_folder_name
    file_name << "_"
    file_name << type
    file_name << number

    image = Image.new(permitted_params)
    image.sub_folder_name = sub_folder_name
    image.private_folder_name = private_folder_name
    image.file_name = file_name
    image.save

    # begin
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_Sym_L_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_Sym_L_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_Sym_L_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_Sym_L_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_Sym_R_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_Sym_R_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_Sym_R_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_Sym_R_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_PWC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_PWC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_PWC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_PWC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_SBC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_SBC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_SBC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_SBC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_GR_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_GR_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_GR_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_GR_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_PLC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_PLC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_PLC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_PLC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_UVC_")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_PWC_W")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_E")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_Sp_Pore_Cust")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_Sp_Spot_Cust")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_Sp_Wr_Cust")
    #   image_upload_was(serial: serial, measureno: measureno, number: nil, type: "_F_PW_SK_L_SIDE")
    # rescue
    # end

    # =======================================================
    # WAS 업로드 마친 이미지 -> FTP 서버로 복사
    # 1. 디렉토리 만들기
    # 2. 파일 복사
    # image_copy_ftp(serial: custserial, measureno: measureno, number: number, type: type)
    # Success!!!!!
  end

  def image_upload_was(custserial: nil, measureno: nil, number: nil, type: nil)

  end

  def image_copy_ftp(custserial: nil, measureno: nil, number: nil, type: nil)
    custserial = "879"
    measureno = 1
    number = "1"
    type = "_Sym_L_"

    user = Custinfo.where(custserial: custserial).first
    sub_folder_name = (((user.custserial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"

    ftp_path = ""
    if !user.ch_cd.nil?
      ftp_path = "'ftp://165.244.88.27/"
      ftp_path << user.ch_cd.to_s
      ftp_path << "/"
    else
      ftp_path = "'ftp://165.244.88.27/CNP/'"
    end

    make_dir_command = ""
    if !user.ch_cd.nil?
      make_dir_command << "/"
      make_dir_command << user.ch_cd.to_s
      make_dir_command << "/"
    else
      make_dir_command << "/CNP/"
    end

    Rails.logger.info make_dir_command

    make_dir_command << sub_folder_name
    Rails.logger.info make_dir_command

    system("echo folder Create")
    folder_create_command = "curl -p --insecure "
    folder_create_command << ftp_path
    folder_create_command << "' -u 'janus:pielgahn2012#1' -Q '-MKD "
    folder_create_command << make_dir_command
    folder_create_command << "' --ftp-create-dirs"
    # system(folder_create_command)

    # Curl -p - --insecure"ftp://165.244.88.27/CNP/" --user"janus:pielgahn2012#1" -Q "-MKD /CNP/test"--ftp-create-dirs
    # 100-P 만들기 end
    # Success!!!!

    make_dir_command << "/"
    make_dir_command << custserial.to_i.to_s
    make_dir_command << "-"
    make_dir_command << measureno.to_i.to_s

    ftp_path << sub_folder_name
    ftp_path << "/"

    folder_create_command = ""
    folder_create_command = "curl -p --insecure "
    folder_create_command << ftp_path
    folder_create_command << "' -u 'janus:pielgahn2012#1' -Q '-MKD "
    folder_create_command << make_dir_command
    folder_create_command << "' --ftp-create-dirs"
    # system(folder_create_command)

    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/' -u 'janus:pielgahn2012#1' -Q '-MKD /CNP/900-P/839-1' --ftp-create-dirs"
    # 100-P/839-1 만들기
    # Success!!!!

    file_path = ""
    file_path << make_dir_command
    file_path << "/"
    file_path << custserial.to_i.to_s
    file_path << "-"
    file_path << measureno.to_i.to_s
    file_path << type
    file_path << measureno.to_s
    file_path << ".jpg"

    ftp_path << custserial.to_i.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << "/"

    file_copy_command = ""
    file_copy_command = "curl -p --insecure "
    file_copy_command << ftp_path
    file_copy_command << "' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/public"
    file_copy_command << file_path
    file_copy_command << "' --ftp-create-dirs"
    # system(file_copy_command)
    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/879-1/' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/public/CNP/900-P/879-1/879-1_Sym_L_1.jpg' --ftp-create-dirs"
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :measureno, :number, :type, :image)
  end
end
