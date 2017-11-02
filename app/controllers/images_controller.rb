class ImagesController < ApplicationController
  def create
    # 폴더 만들기
    # 디스크 크기 확인 후 삭제
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
    if type.include?("F_PL") || type.include?("F_UV") || type.include?("F_WH")
    else
      sub_folder_name << "-P"
    end

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
    if number.to_i != 0
      file_name << "_"
      file_name << number
    end
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
      image_copy_to_ftp(custserial: custserial, ch_cd: ch_cd, measureno: measureno, number: number, type: type)
    end
    render :body => "Success!!!", status: 200
  end

  def image_copy_to_ftp(custserial: nil, ch_cd: nil, measureno: nil, number: nil, type: nil)
    custserial = custserial
    ch_cd = ch_cd
    measureno = measureno
    number = number
    type = type

    sub_folder_name = (((custserial.to_i / 100) * 100) + 100).to_s
    if type.include?("F_PL") || type.include?("F_UV") || type.include?("F_WH")
    else
      sub_folder_name << "-P"
    end

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

    make_dir_command << sub_folder_name

    system("echo folder Create")
    folder_create_command = "curl -p --insecure "
    folder_create_command << ftp_path
    folder_create_command << "' -u 'janus:pielgahn2012#1' -Q '-MKD "
    folder_create_command << make_dir_command
    folder_create_command << "' --ftp-create-dirs"

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
    if number.to_i != 0
      file_path << "_"
      file_path << number.to_s
    end
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
    (0..10).each do |i|
      break if system(file_copy_command)
    end
    # "curl -p --insecure 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' -T '/home/janustabuser/lgcare/current/public/CNP/900-P/839-1/839-1_Sym_L_1.jpg' --ftp-create-dirs"
    #  ls_command = "curl -l 'ftp://165.244.88.27/CNP/900-P/839-1/' -u 'janus:pielgahn2012#1' --ftp-create-dirs"
  end

  def type_image_download
    # serial="839"
    # measureno="1"
    # number="1"
    # ch_cd="CNP"
    # type="Sym_L"

    serial = params[:custserial]
    measureno = params[:measureno]
    number = params[:number]
    ch_cd = params[:ch_cd]
    type = params[:type]

    #이미지 가져오기
    sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s
    if type.include?("F_PL") || type.include?("F_UV") || type.include?("F_WH")
    else
      sub_folder_name << "-P"
    end

    ftp_path = ""
    ftp_path = "ftp://165.244.88.27/"
    ftp_path << ch_cd
    ftp_path << "/"

    ftp_path << sub_folder_name.to_s

    ftp_path << "/"
    ftp_path << serial.to_i.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << "/"
    ftp_path << serial.to_i.to_s
    ftp_path << "-"
    ftp_path << measureno.to_i.to_s
    ftp_path << "_"
    ftp_path << type
    if number.to_i != 0
      ftp_path << "_"
      ftp_path << number
    end
    ftp_path << ".jpg"

    system("echo FILE Download")
    file_get_command = "wget --user janus --password pielgahn2012#1 "
    file_get_command << ftp_path
    file_get_command << " -N -P "

    make_dir_command = "mkdir "
    make_dir_command << "public/"
    make_dir_command << ch_cd
    make_dir_command << "/"

    system(make_dir_command)

    make_dir_command << sub_folder_name
    system(make_dir_command)

    make_dir_command << "/"
    make_dir_command << serial.to_i.to_s
    make_dir_command << "-"
    make_dir_command << measureno.to_i.to_s
    system(make_dir_command)

    # file_get_command << "public/CNP/"
    file_get_command << "public/"
    file_get_command << ch_cd
    file_get_command << "/"

    file_get_command << sub_folder_name
    file_get_command << "/"
    file_get_command << serial.to_i.to_s
    file_get_command << "-"
    file_get_command << measureno.to_i.to_s
    # wget --user janus --password pielgahn2012#1 ftp://165.244.88.27/CNP/100-P/41-1/41-1_F_PW_SK_L_SIDE.jpg -N -P public/CNP/100-P/41-1
    (0..10).each do |i|
      break if system(file_get_command)
    end

    if number.to_i != 0
      file_exist_command = "public/"+ch_cd+"/"+sub_folder_name+"/"+serial.to_s+"-"+measureno.to_s+"/"+serial.to_s+"-"+measureno.to_s+"_"+type+"_"+number+".jpg"
    else
      file_exist_command = "public/"+ch_cd+"/"+sub_folder_name+"/"+serial.to_s+"-"+measureno.to_s+"/"+serial.to_s+"-"+measureno.to_s+"_"+type+".jpg"
    end

    if File.exist?(file_exist_command)
      render :text => "Success!!!", status: :ok
    else
      render :text => "Fail!!!", status: 404
    end
  end
end
