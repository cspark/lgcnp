class Api::Notice::NoticeHistoryController < Api::ApplicationController
  def index
    list = FcnoticeHistory.all.order("end_date desc")
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "FcnoticeHistory is not exist!!!", status: 204
    end
  end

  def create
    notice_history = FcnoticeHistory.new(permitted_params)

    if notice_history.save
      render json: notice_history.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def notice_download
    check_was_disk

    Rails.logger.info "notice_download!!!"
    filename = params[:filename]
    Rails.logger.info filename

    make_dir_command = "mkdir "
    make_dir_command << "public/Admin"
    Rails.logger.info make_dir_command
    system(make_dir_command)
    make_dir_command << "/Notice"
    system(make_dir_command)

    ftp_path = ""
    ftp_path << "ftp://165.244.88.27/Admin/Notice/"
    ftp_path << filename

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "
    file_get_command << "public/Admin/Notice"

    Rails.logger.info file_get_command
    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    system(file_get_command)

    file_exist_command = "public/Admin/Notice/"
    file_exist_command << filename

    Rails.logger.info file_exist_command
    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def notice_upload
    check_was_disk

    Rails.logger.info "notice_upload!!!"
    filename = params[:filename]

    make_dir_command = "mkdir "
    make_dir_command << "public/Admin"
    system(make_dir_command)
    make_dir_command << "/Notice"
    system(make_dir_command)

    uploader = NoticeUploader.new
    uploader.temp_save_update_launcher(filename: filename)
    uploader.store!(params[:file])

    ftp_path = ""
    ftp_path << "ftp://165.244.88.27/Admin/Notice/"

    file_path = ""
    file_path << "public/Admin/Notice/"
    file_path << filename
    file_path << ".zip"

    file_copy_command = ""
    file_copy_command = "curl -p --insecure '"
    file_copy_command << ftp_path
    file_copy_command << "' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/"
    file_copy_command << file_path
    file_copy_command << "' --ftp-create-dirs"
    Rails.logger.info file_copy_command
    system(file_copy_command)

    file_exist_command = "public/Admin/Notice/"
    file_exist_command << filename
    file_exist_command << ".zip"

    Rails.logger.info file_exist_command
    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def check_was_disk
    spaceMb_i = `df -m /dev/mapper/DATAVG-lv_data`.split(/\b/)[28].to_i
    Rails.logger.info "spaceMb_i !!!!!"
    Rails.logger.info spaceMb_i
    if spaceMb_i < 2048
      Rails.logger.info "spaceMb_i < 2048 !!!!"
      system("rm -rf public/BEAU/*")
      system("rm -rf public/CNP/*")
      system("rm -rf public/CLAB/*")
      system("rm -rf public/CNPR/*")
      system("rm -rf public/RLAB/*")
      system("rm -rf public/LABO/*")
      system("rm -rf public/MART/*")
      system("rm -rf public/TMR/*")
      system("rm -rf public/ONEP/*")
      system("rm -rf public/TEST/*")
    end
  end

  private
  def permitted_params
    params.permit(:upload_date, :begin_date, :end_date, :file_name, :notice_comment)
  end
end