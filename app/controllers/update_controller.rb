class UpdateController < ApplicationController
  def index
    list = FcupdateHistory.list(version_name: params[:version_name], ch_cd: params[:ch_cd])

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

    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end
    system(make_dir_command)
    make_dir_command << "/Update"
    system(make_dir_command)

    ftp_path = ""
    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Update/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Update/"
    end

    ftp_path << filename

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "
    if params.has_key?(:staging)
      file_get_command << "public/Admin_Test/Update"
    else
      file_get_command << "public/Admin/Update"
    end

    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    system(file_get_command)
    Rails.logger.info "file_get_command command : #{file_get_command}"

    if params.has_key?(:staging)
      file_exist_command = "public/Admin_Test/Update/"
    else
      file_exist_command = "public/Admin/Update/"
    end
    file_exist_command << filename

    Rails.logger.info "file command : #{file_exist_command}"

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

    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end

    system(make_dir_command)
    make_dir_command << "/Update"
    system(make_dir_command)

    uploader = LauncherUploader.new
    if params.has_key?(:staging)
      uploader.temp_save_update_launcher(filename: filename, staging: true)
    else
      uploader.temp_save_update_launcher(filename: filename, staging: false)
    end
    uploader.store!(params[:file])

    ftp_path = ""
    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Update/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Update/"
    end


    file_path = ""
    if params.has_key?(:staging)
      file_path << "public/Admin_Test/Update/"
    else
      file_path << "public/Admin/Update/"
    end

    file_path << filename
    file_path << ".zip"

    file_copy_command = ""
    file_copy_command = "curl -p --insecure '"
    file_copy_command << ftp_path
    file_copy_command << "' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/"
    file_copy_command << file_path
    file_copy_command << "' --ftp-create-dirs"
    (0..10).each do |i|
      break if system(file_copy_command)
    end

    if params.has_key?(:staging)
      file_exist_command = "public/Admin_Test/Update/"
    else
      file_exist_command = "public/Admin/Update/"
    end

    file_exist_command << filename
    file_exist_command << ".zip"

    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def check_was_disk
    spaceMb_i = `df -m /dev/mapper/DATAVG-lv_data`.split(/\b/)[28].to_i
    if spaceMb_i < 2048
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
    params.permit(:release_date, :version_name, :launcher_yn, :upt_entry_num, :upt_total_filesize, :upt_comment, :ch_cd)
  end
end
