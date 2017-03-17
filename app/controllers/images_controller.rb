class ImagesController < Api::ApplicationController
  def create
    # 폴더 만들기
    custserial = params[:custserial]
    ch_cd = params[:ch_cd]
    measureno = params[:measureno].to_i
    number = params[:number]
    type = params[:type]

    # custserial = "839"
    # ch_cd = "CNP"
    # measureno = 1
    # number = "1"
    # type = "Sym_L"

    sub_folder_name = (((custserial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"

    make_dir_command = "mkdir "
    if !ch_cd.nil?
      make_dir_command << "public/"
      make_dir_command << ch_cd.to_s
      make_dir_command << "/"
    else
      make_dir_command << "public/CNP/"
    end

    system(make_dir_command)

    make_dir_command << sub_folder_name
    system(make_dir_command)

    make_dir_command << "/"
    make_dir_command << custserial
    make_dir_command << "-"
    make_dir_command << measureno.to_i.to_s
    system(make_dir_command)
    # 업로드 하기 전 WAS 폴더 만들기
    # Success!!!!

    # ======================================
    # 이미지 WAS 서버 업로드
    private_folder_name = ""
    private_folder_name << custserial.to_i.to_s
    private_folder_name << "-"
    private_folder_name << measureno.to_i.to_s

    file_name = ""
    file_name << private_folder_name
    file_name << "_"
    file_name << type
    file_name << "_"
    file_name << number
    file_extension = "jpg"

    uploader = ImageUploader.new
    uploader.temp_save(file_name: file_name, file_extension: file_extension, image_ch_cd: ch_cd, sub_folder_name: sub_folder_name, private_folder_name: private_folder_name)
    uploader.store!(params[:image])

    # =======================================================
    # WAS 업로드 마친 이미지 -> FTP 서버로 복사
    # 1. 디렉토리 만들기
    # 2. 파일 복사
    # Success!!!!!
    if Rails.env.production? || Rails.env.staging?
      image_copy_ftp(custserial: custserial, ch_cd: ch_cd, measureno: measureno, number: number, type: type)
    end
    render :body => "Success!!!", status: 200
  end

  def image_copy_ftp(custserial: nil, ch_cd: nil, measureno: nil, number: nil, type: nil)
    Rails.logger.info "image_copy_ftp!!!"
    custserial = custserial
    ch_cd = ch_cd
    measureno = measureno
    number = number
    type = type

    sub_folder_name = (((custserial.to_i / 100) * 100) + 100).to_s
    sub_folder_name << "-P"

    ftp_path = ""
    if !ch_cd.nil?
      ftp_path = "'ftp://165.244.88.27/"
      ftp_path << ch_cd.to_s
      ftp_path << "/"
    else
      ftp_path = "'ftp://165.244.88.27/CNP/'"
    end

    make_dir_command = ""
    if !ch_cd.nil?
      make_dir_command << "/"
      make_dir_command << ch_cd.to_s
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

    Rails.logger.info folder_create_command
    system(folder_create_command)

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
    Rails.logger.info folder_create_command
    system(folder_create_command)

    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/' -u 'janus:pielgahn2012#1' -Q '-MKD /CNP/900-P/839-1' --ftp-create-dirs"
    # 100-P/839-1 만들기
    # Success!!!!

    file_path = ""
    file_path << make_dir_command
    file_path << "/"
    file_path << custserial.to_i.to_s
    file_path << "-"
    file_path << measureno.to_i.to_s
    file_path << "_"
    file_path << type
    file_path << "_"
    file_path << number.to_s
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
    Rails.logger.info file_copy_command
    system(file_copy_command)
    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/public/CNP/900-P/839-1/839-1_Sym_L_1.jpg' --ftp-create-dirs"
    #  ls_command = "curl -l 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' --ftp-create-dirs"
  end
end
