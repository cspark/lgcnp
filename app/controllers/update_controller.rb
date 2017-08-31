class UpdateController < ApplicationController
  def index
    list = FcupdateHistory.list(version_name: params[:version_name])

    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "FcupdateHistory is not exist!!!", status: 204
    end
  end

  def create
    fcupdate_history = FcupdateHistory.new(permitted_params)

    if fcupdate_history.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  def is_update
    version_code = params[:version_code]

    current_version_code = 12

    if version_code.to_i < current_version_code.to_i
      url_json = { :download_url => 'http://203.247.132.106/app.apk' }
      render json: url_json.to_json, status: 200
    else
      render json: "", status: 200
    end
  end

  def update_launcher_download
    check_was_disk

    Rails.logger.info "update_launcher_download!!!"
    filename = params[:filename]
    Rails.logger.info filename

    make_dir_command = "mkdir "
    make_dir_command << "public/Admin"
    Rails.logger.info make_dir_command
    system(make_dir_command)
    make_dir_command << "/Update"
    system(make_dir_command)

    ftp_path = ""
    ftp_path << "ftp://165.244.88.27/Admin/Update/"
    ftp_path << filename

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "
    file_get_command << "public/Admin/Update"

    Rails.logger.info file_get_command
    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    system(file_get_command)

    file_exist_command = "public/Admin/Update/"
    file_exist_command << filename

    Rails.logger.info file_exist_command
    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/public/CNP/900-P/839-1/839-1_Sym_L_1.jpg' --ftp-create-dirs"
    #  ls_command = "curl -l 'ftp://165.244.88.27/Admin/Update//' -u 'janus:pielgahn2012#1' --ftp-create-dirs"
  end

  def update_launcher_upload
    check_was_disk

    Rails.logger.info "update_launcher_upload!!!"
    filename = params[:filename]

    make_dir_command = "mkdir "
    make_dir_command << "public/Admin"
    system(make_dir_command)
    make_dir_command << "/Update"
    system(make_dir_command)

    uploader = LauncherUploader.new
    uploader.temp_save_update_launcher(filename: filename)
    uploader.store!(params[:file])

    ftp_path = ""
    ftp_path << "ftp://165.244.88.27/Admin/Update/"

    file_path = ""
    file_path << "public/Admin/Update/"
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

    file_exist_command = "public/Admin/Update/"
    file_exist_command << filename
    file_exist_command << ".zip"

    Rails.logger.info file_exist_command
    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def move_update_launcher
    check_was_disk

    Rails.logger.info "update_launcher_download!!!"
    filename = params[:filename]
    origin_path = params[:origin_path]
    destination_path = params[:destination_path]
    file_extension = params[:file_extension]
    Rails.logger.info filename

    make_dir_command = "mkdir "
    make_dir_command << "public"
    make_dir_command << origin_path
    Rails.logger.info make_dir_command
    system(make_dir_command)
    make_dir_command << "/Update"
    system(make_dir_command)

    ftp_path = ""
    ftp_path << "ftp://165.244.88.27"
    ftp_path << origin_path
    ftp_path << "/"

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << filename
    file_get_command << "."
    file_get_command << file_extension
    file_get_command << " -N -P "
    file_get_command << "public"
    file_get_command << origin_path

    Rails.logger.info file_get_command
    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/Admin/Update/Update_2-17-805-0.zip -N -P public/Admin/Update
    system(file_get_command)

    # file_delete_command = "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -Q '-DELE 839-1_Sym_L_1.jpg' --ftp-create-dirs"

    file_delete_command = "curl -p --insecure "
    file_delete_command << ftp_path
    file_delete_command << " -u 'janus:pielgahn2012#1' -Q '-DELE "
    file_delete_command << filename
    file_delete_command << "."
    file_delete_command << file_extension
    file_delete_command << "' --ftp-create-dirs"
    system(file_delete_command)


    file_path = ""
    file_path << "public"
    file_path << origin_path
    file_path << "/"
    file_path << filename
    file_path << "."
    file_path << file_extension

    file_copy_command = ""
    file_copy_command = "curl -p --insecure '"
    file_copy_command << "ftp://165.244.88.27"
    file_copy_command << destination_path
    file_copy_command << "' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/"
    file_copy_command << file_path
    file_copy_command << "' --ftp-create-dirs"
    Rails.logger.info file_copy_command
    system(file_copy_command)

    file_exist_command = "public/Admin/Update/"
    file_exist_command << filename

    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end

    # file_delete_command = "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -Q '-DELE 839-1_Sym_L_1.jpg' --ftp-create-dirs"
    # folder_delete_command = "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1' -u 'janus:pielgahn2012#1' -Q '-RMD 839-1' --ftp-create-dirs"

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
    params.permit(:release_date, :version_name, :launcher_yn, :upt_entry_num, :upt_total_filesize, :upt_comment)
  end
end
