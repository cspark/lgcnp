class Api::Notice::FcNoticeHistoryController < Api::ApplicationController
  def index
    interview = FcgeneInterview.where(custserial: params[:custserial], measureno: params[:measureno].to_i).first
    if !interview.nil?
      render json: interview.to_api_hash, status: :ok
    else
      render :text => "FcgeneInterview is not exist!!!", status: 204
    end
  end

  def create
    interview = FcgeneInterview.new(permitted_params)

    t = Time.now
    interview.uptdate = t.to_s.split(" ")[0]

    if interview.save
      render json: interview.to_api_hash, status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end

  def update
    interview = FcgeneInterview.where(custserial: params[:custserial], measureno: params[:measureno].to_i).first
    if !interview.nil?
      interview.update(permitted_params)
      t = Time.now
      interview.uptdate = t.to_s.split(" ")[0]

      if interview.save
        render json: interview.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    else
      render json: "FcgeneInterview is not exist!!!", status: 204
    end
  end

  def notice_download
    #이미지 가져오기
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
    params.permit(:custserial, :ch_cd, :gene_barcode, :measureno)
  end
end
