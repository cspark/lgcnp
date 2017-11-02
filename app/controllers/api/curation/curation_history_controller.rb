class Api::Curation::CurationHistoryController < Api::ApplicationController
  def index
    list = FccurationHistory.all.order("version_name asc")
    if list.count > 0
      render json: api_hash_for_list(list), status: :ok
    else
      render :text => "FccurationHistory is not exist!!!", status: 204
    end
  end

  def create
    fccuration_history = FccurationHistory.new(permitted_params)

    if fccuration_history.save
      render json: fccuration_history.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def update
    fccuration_history = FccurationHistory.where(upload_date: params[:upload_date]).first
    if !fccuration_history.nil?
      if params[:cura_comment].present?
        fccuration_history.cura_comment = params[:cura_comment]
      end
      if fccuration_history.save
        render json: fccuration_history.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render json: "FcnoticeHistory is not exist!!!", status: 204
    end
  end

  def curation_download
    check_was_disk

    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end

    system(make_dir_command)
    make_dir_command << "/Curation"
    system(make_dir_command)

    ftp_path = ""
    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Curation/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Curation/"
    end

    ftp_path << filename

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "
    if params.has_key?(:staging)
      file_get_command << "public/Admin_Test/Curation"
    else
      file_get_command << "public/Admin/Curation"
    end

    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    (0..10).each do |i|
      break if system(file_get_command)
    end

    if params.has_key?(:staging)
      file_exist_command = "public/Admin_Test/Curation/"
    else
      file_exist_command = "public/Admin/Curation/"
    end

    file_exist_command << filename

    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def curation_upload
    check_was_disk

    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end

    system(make_dir_command)
    make_dir_command << "/Curation"
    system(make_dir_command)

    uploader = CurationUploader.new
    if params.has_key?(:staging)
      uploader.temp_save_update_launcher(filename: filename, staging: true)
    else
      uploader.temp_save_update_launcher(filename: filename, staging: false)
    end

    uploader.store!(params[:file])

    ftp_path = ""
    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Curation/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Curation/"
    end

    file_path = ""
    if params.has_key?(:staging)
      file_path << "public/Admin_Test/Curation/"
    else
      file_path << "public/Admin/Curation/"
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
      file_exist_command = "public/Admin_Test/Curation/"
    else
      file_exist_command = "public/Admin/Curation/"
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
    params.permit(:upload_date, :version_name, :cura_entry_filename, :cura_comment)
  end
end
