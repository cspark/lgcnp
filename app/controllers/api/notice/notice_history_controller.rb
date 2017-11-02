class Api::Notice::NoticeHistoryController < Api::ApplicationController
  def index
    list = FcnoticeHistory.list(ch_cd: params[:ch_cd])
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

  def update
    fcnotice_history = FcnoticeHistory.where(upload_date: params[:upload_date]).first
    if !fcnotice_history.nil?
      if params[:begin_date].present?
        fcnotice_history.begin_date = params[:begin_date]
      end
      if params[:end_date].present?
        fcnotice_history.end_date = params[:end_date]
      end
      if params[:notice_comment].present?
        fcnotice_history.notice_comment = params[:notice_comment]
      end
      if fcnotice_history.save
        render json: fcnotice_history.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render json: "FcnoticeHistory is not exist!!!", status: 204
    end
  end

  def notice_download
    check_was_disk

    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end
    system(make_dir_command)
    make_dir_command << "/Notice"
    system(make_dir_command)

    ftp_path = ""
    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Notice/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Notice/"
    end

    ftp_path << filename

    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "
    if params.has_key?(:staging)
      file_get_command << "public/Admin_Test/Notice"
    else
      file_get_command << "public/Admin/Notice"
    end


    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    (0..10).each do |i|
      break if system(file_get_command)
    end

    if params.has_key?(:staging)
      file_exist_command = "public/Admin_Test/Notice/"
    else
      file_exist_command = "public/Admin/Notice/"
    end

    file_exist_command << filename

    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def notice_upload
    check_was_disk
    filename = params[:filename]

    make_dir_command = "mkdir "
    if params.has_key?(:staging)
      make_dir_command << "public/Admin_Test"
    else
      make_dir_command << "public/Admin"
    end

    system(make_dir_command)
    make_dir_command << "/Notice"
    system(make_dir_command)

    uploader = NoticeUploader.new
    if params.has_key?(:staging)
      uploader.temp_save_update_launcher(filename: filename, staging: true)
    else
      uploader.temp_save_update_launcher(filename: filename, staging: false)
    end

    uploader.store!(params[:file])

    ftp_path = ""

    if params.has_key?(:staging)
      ftp_path << "ftp://165.244.88.27/Admin_Test/Notice/"
    else
      ftp_path << "ftp://165.244.88.27/Admin/Notice/"
    end


    file_path = ""
    if params.has_key?(:staging)
      file_path << "public/Admin_Test/Notice/"
    else
      file_path << "public/Admin/Notice/"
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
      file_exist_command = "public/Admin_Test/Notice/"
    else
      file_exist_command = "public/Admin/Notice/"
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
    params.permit(:upload_date, :begin_date, :end_date, :file_name, :notice_comment, :ch_cd)
  end
end
