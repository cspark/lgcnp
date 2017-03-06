class Admin::ImageController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def index
    if params.has_key?(:search) && params[:search].length != 0
      @search = params[:search]
      @users = Custinfo.where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc").page(params[:page]).per(20)
      user_ids = []
      @users.each do |user|
        user_ids << user.custserial
      end
      @fcdatas = BeauFcdata.where(custserial: user_ids)
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(10)
    else
      @search = ""
      @fcdatas = BeauFcdata.all
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(10)
    end

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def show
    serial = params[:userId]
    measureno = params[:measureno]
    ch_cd = params[:ch_cd]

    if Rails.env.production? || Rails.env.staging?
      @fcdata = BeauFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s << "-p"
      @path << sub_folder_name.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "_"

      image_download(serial: serial, measureno: measureno, number: "1", type: "_Sym_L_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_Sym_L_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_Sym_L_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_Sym_L_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_L_")

      image_download(serial: serial, measureno: measureno, number: "1", type: "_Sym_R_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_Sym_R_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_Sym_R_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_Sym_R_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_R_")

      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_")

      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_PWC_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_PWC_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_PWC_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_PWC_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_PWC_")
      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_")

      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_SBC_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_SBC_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_SBC_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_SBC_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_SBC_")
      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_GR_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_GR_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_GR_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_GR_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_GR_")

      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_PLC_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_PLC_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_PLC_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_PLC_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_PLC_")
      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_UVC_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_UVC_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_UVC_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_UVC_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_UVC_")
      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_")
      image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_UVC_")
      image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_UVC_")
      image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_UVC_")
      image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_UVC_")
      BeauFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_UVC_")

      image_download(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_PWC_W")
      image_download(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_E")
      image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Pore_Cust")
      image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Spot_Cust")
      image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Wr_Cust")
    else
      serial = "2"
      measureno = 2
      ch_cd = "CNP"

      @fcdata = BeauFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s << "-p"
      @path << sub_folder_name.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "_"
    end
  end

  def image_download(serial: nil, measureno: nil, number: nil, type: nil)
    #이미지 가져오기
    Rails.logger.info serial
    user = Custinfo.where(custserial: serial).first
    sub_folder_name = (((user.custserial.to_i / 100) * 100) + 100).to_s
    # sub_folder_name = "100"
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

    ftp_path << sub_folder_name.to_s

    ftp_path << "/"
    ftp_path << user.custserial.to_i.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << "/"
    ftp_path << user.custserial.to_i.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << type
    ftp_path << number if !number.nil?
    ftp_path << ".jpg"
    Rails.logger.info ftp_path

    system("echo FILE Download")
    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "

    make_dir_command = "mkdir "
    # make_dir_command << "public/CNP/"
    if !user.ch_cd.nil?
      make_dir_command << "public/"
      make_dir_command << user.ch_cd.to_s
      make_dir_command << "/"
    else
      make_dir_command << "public/CNP/"
    end

    Rails.logger.info make_dir_command
    system(make_dir_command)

    make_dir_command << sub_folder_name
    Rails.logger.info make_dir_command
    system(make_dir_command)

    make_dir_command << "/"
    make_dir_command << user.custserial.to_i.to_s
    make_dir_command << "-"
    make_dir_command << measureno.to_i.to_s
    Rails.logger.info make_dir_command
    system(make_dir_command)

    # file_get_command << "public/CNP/"
    if !user.ch_cd.nil?
      file_get_command << "public/"
      file_get_command << user.ch_cd.to_s
      file_get_command << "/"
    else
      file_get_command << "public/CNP/"
    end

    file_get_command << sub_folder_name
    file_get_command << "/"
    file_get_command << user.custserial.to_i.to_s
    file_get_command << "-"
    file_get_command << measureno.to_i.to_s
    Rails.logger.info "final"
    Rails.logger.info file_get_command
    system(file_get_command)
  end
end
