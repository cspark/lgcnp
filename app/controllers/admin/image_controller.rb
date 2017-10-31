class Admin::ImageController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Image User List"
      history.save
    end

    @start_date = "2017-01-25"
    @end_date = Date.today
    @today = Date.today

    start_date = params[:start_date]
    end_date = params[:end_date]
    name = params[:name]
    start_measureno = params[:start_measureno]
    end_measureno = params[:end_measureno]
    select_channel = params[:select_channel]
    shop_cd = params[:shop_cd]
    custserial = params[:custserial]

    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @name = name if !name.blank?
    @start_measureno = start_measureno if !start_measureno.blank?
    @end_measureno = end_measureno if !end_measureno.blank?
    @select_channel = select_channel if select_channel != "all"
    @shop_cd = shop_cd if !shop_cd.blank?
    @name = name if !name.blank?
    @custserial = custserial

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @fcdatas = []
    if Rails.env.production? || Rails.env.staging?
      if @is_admin_init
        @fcdatas_excel = @fcdatas
        @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
      else
        scoped = Fcdata.all
        temp_end_date = @end_date.to_date + 1.day
        scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
        scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
        scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
        scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.blank?
        scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
        scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
        scoped = scoped.order("measuredate desc")

        scoped.each do |fcdata|
          custinfo = Custinfo.where(custserial: fcdata.custserial).first
          is_contain = true

          if !custinfo.nil?
            if !custinfo.custname.nil? && !@name.blank?
              if !custinfo.custname.include? @name
                is_contain = false
              end
            end
          end

          if is_contain == true
            @fcdatas << fcdata
          end
        end

        @fcdatas_excel = @fcdatas
        @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
      end
    else
      scoped = Fcdata.all
      scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
      scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
      scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.blank?
      scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.order("uptdate desc")

      scoped.each do |fcdata|
        custinfo = Custinfo.where(custserial: fcdata.custserial).first
        is_contain = true

        if !custinfo.nil?
          if !custinfo.custname.nil? && !@name.blank?
            if !custinfo.custname.include? @name
              is_contain = false
            end
          end
        end

        if is_contain == true
          @fcdatas << fcdata
        end
      end

      @fcdatas_excel = @fcdatas
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    serial = params[:custserial]
    measureno = params[:measureno]
    ch_cd = params[:ch_cd]

    # 디스크 크기 확인 후 삭제
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

    if Rails.env.production? || Rails.env.staging?
      @fcdata = AdminFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s << "-P"
      @path << sub_folder_name.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "_"

      image_download_ch_cd = @fcdata.ch_cd
      begin
        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_L_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_L_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_L_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_L_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_Sym_L_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_Sym_L_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_Sym_L_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_Sym_L_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_R_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_R_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_R_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sym_R_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_Sym_R_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_Sym_R_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_Sym_R_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_Sym_R_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_PWC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_PWC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_PWC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_PWC_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_SBC_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_SBC_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_SBC_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_SBC_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_SBC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_SBC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_SBC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_SBC_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_GR_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_GR_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_GR_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_GR_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_GR_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_GR_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_GR_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_GR_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_PLC_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_PLC_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_PLC_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_PLC_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_PLC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_PLC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_PLC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_PLC_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_UVC_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_UVC_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_UVC_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UVGR_UVC_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UVGR_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UVGR_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UVGR_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UVGR_UVC_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_UVC_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_UVC_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_UVC_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_PL_UVC_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_PL_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_PL_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_PL_UVC_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_PL_UVC_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_W.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_E.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Pore_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Spot_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Wr_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_PW_SK_L_SIDE.jpg")
          image_download(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_PWC_W", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_F_FM_WH_E", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Pore_Cust", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Spot_Cust", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Wr_Cust", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_F_PW_SK_L_SIDE", ch_cd: image_download_ch_cd)
        end

        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_L_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_R_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_PWC_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_SBC_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_GR_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_PLC_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_UVC_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_UVC_")

        zip_path = @path.split("/")[0] +"/"+ @path.split("/")[1]
        generate_tgz(relation: @fcdata, path: @path)

        Rails.logger.info params[:is_api]
        if params.has_key?(:is_api)
          render json: "", status: :ok
        else
          respond_to do |format|
            format.html
          end
        end
      rescue
        if params.has_key?(:is_api)
          render :text => "Fail!!!", status: 404
        else
          respond_to do |format|
            format.html
          end
        end
      end
    else
      serial = "2"
      measureno = 2
      ch_cd = "CNP"

      @fcdata = AdminFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((1 / 100) * 100) + 100).to_s << "-P"
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

      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_L_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "Sym_R_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_PWC_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_GR_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_SBC_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_PLC_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UVGR_UVC_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_PL_UVC_")

      zip_path = @path.split("/")[0] +"/"+ @path.split("/")[1]
      generate_tgz(relation: @fcdata, path: @path)
    end
  end

  def generate_tgz(relation: nil, path: nil)
    zip_path = path.split("/")[0] +"/"+ path.split("/")[1]
    file_path = path.split("/")[2]

    folder = "public/"+relation.ch_cd+"/"+zip_path
    input_filenames = [ file_path+'F_FM_UV_merge.jpg', file_path+'F_FM_WH_merge.jpg', file_path+'Sp_Pore_Cust.jpg', file_path+'Sp_Spot_Cust.jpg', file_path+'Sp_Wr_Cust.jpg' ]

    zipfile_name = "public/"+relation.ch_cd+"/"+path+"all_image_merge.zip"

    if !File.exist?("public/"+relation.ch_cd+"/"+path+"all_image_merge.zip")
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        input_filenames.each do |filename|
          zipfile.add(filename, folder + '/' + filename)
        end
      end
    end
  end

  def image_download(serial: nil, measureno: nil, number: nil, type: nil, ch_cd: nil)
    #이미지 가져오기
    Rails.logger.info serial
    user = Custinfo.where(custserial: serial).first
    sub_folder_name = (((user.custserial.to_i / 100) * 100) + 100).to_s
    # sub_folder_name = "100"
    sub_folder_name << "-P"
    Rails.logger.info sub_folder_name

    ftp_path = ""
    if !ch_cd.nil?
      ftp_path = "ftp://165.244.88.27/"
      ftp_path << ch_cd.to_s
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
    if !ch_cd.nil?
      make_dir_command << "public/"
      make_dir_command << ch_cd.to_s
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
    if !ch_cd.nil?
      file_get_command << "public/"
      file_get_command << ch_cd.to_s
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
    (0..10).each do |i|
      Rails.logger.info i
      break if system(file_get_command)
    end
  end

# 최소의 이미지만 보여주는 리스트
  def minimum_image_list
    if params.has_key?(:isExcel) && params[:isExcel] && session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user]
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Image User List"
      history.save
    end

    @start_date = "2017-01-25"
    @end_date = Date.today
    @today = Date.today

    start_date = params[:start_date]
    end_date = params[:end_date]
    name = params[:name]
    start_measureno = params[:start_measureno]
    end_measureno = params[:end_measureno]
    select_channel = params[:select_channel]
    shop_cd = params[:shop_cd]
    custserial = params[:custserial]


    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @name = name if !name.blank?
    @start_measureno = start_measureno if !start_measureno.blank?
    @end_measureno = end_measureno if !end_measureno.blank?
    @select_channel = select_channel if select_channel != "all"
    @shop_cd = shop_cd if !shop_cd.blank?
    @name = name if !name.blank?
    @custserial = custserial

    @is_flag = params[:is_flag] if !params[:is_flag].blank?

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @fcdatas = []
    if Rails.env.production? || Rails.env.staging?
      if @is_admin_init
        @fcdatas_excel = @fcdatas
        @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
      else
        scoped = Fcdata.all
        temp_end_date = @end_date.to_date + 1.day
        scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
        scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
        scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
        scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.blank?
        scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
        scoped = scoped.where(custserial: @custserial) if !@custserial.blank?

        scoped = scoped.where(flag: @is_flag) if @is_flag == "T"
        flag_f_scoped = scoped.where(flag: @is_flag) if @is_flag == "F"
        flag_nil_scoped = scoped.where(flag: nil) if @is_flag == "F"
        scoped = flag_f_scoped.or(flag_nil_scoped) if @is_flag == "F"
        scoped = scoped.where(custserial: 0) if @is_flag.blank?
        scoped.joins(:custinfo).where("custinfos.custname LIKE ?", "%#{@name}%") if !@name.nil?
        scoped = scoped.order("measuredate desc")
        @fcdatas = scoped

        @fcdatas_excel = @fcdatas
        @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
      end
    else
      scoped = Fcdata.all
      scoped = scoped.where("measureno >= ?", @start_measureno.to_i) if !@start_measureno.blank?
      scoped = scoped.where("measureno <= ?", @end_measureno.to_i) if !@end_measureno.blank?
      scoped = scoped.where(ch_cd: @select_channel) if !@select_channel.blank?
      scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
      scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
      scoped = scoped.order("uptdate desc")

      scoped.each do |fcdata|
        custinfo = Custinfo.where(custserial: fcdata.custserial).first
        is_contain = true

        if !custinfo.nil?
          if !custinfo.custname.nil? && !@name.blank?
            if !custinfo.custname.include? @name
              is_contain = false
            end
          end
        end

        if is_contain == true
          @fcdatas << fcdata
        end
      end

      @fcdatas_excel = @fcdatas
      @fcdatas = Kaminari.paginate_array(@fcdatas).page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def minimum_show
    serial = params[:custserial]
    measureno = params[:measureno]
    ch_cd = params[:ch_cd]

    if Rails.env.production? || Rails.env.staging?
      # 디스크 크기 확인 후 삭제
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

      @fcdata = AdminFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((serial.to_i / 100) * 100) + 100).to_s << "-P"
      @path << sub_folder_name.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "/"
      @path << serial.to_s
      @path << "-"
      @path << measureno.to_i.to_s
      @path << "_"

      image_download_ch_cd = @fcdata.ch_cd
      begin
        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_UV_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_UV_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_1.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_2.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_3.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_4.jpg")
          image_download(serial: serial, measureno: measureno, number: "1", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "2", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "3", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: "4", type: "_F_FM_WH_", ch_cd: image_download_ch_cd)
        end

        if !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_PWC_W.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_FM_WH_E.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Pore_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Spot_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"Sp_Wr_Cust.jpg") || !File.exist?("public/"+@fcdata.ch_cd+"/"+@path+"F_PW_SK_L_SIDE.jpg")
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Pore_Cust", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Spot_Cust", ch_cd: image_download_ch_cd)
          image_download(serial: serial, measureno: measureno, number: nil, type: "_Sp_Wr_Cust", ch_cd: image_download_ch_cd)
        end

        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_")
        AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_")

        zip_path = @path.split("/")[0] +"/"+ @path.split("/")[1]
        generate_tgz(relation: @fcdata, path: @path)

        Rails.logger.info params[:is_api]
        if params.has_key?(:is_api)
          render json: "", status: :ok
        else
          respond_to do |format|
            format.html
          end
        end
      rescue
        if params.has_key?(:is_api)
          render :text => "Fail!!!", status: 404
        else
          respond_to do |format|
            format.html
          end
        end
      end
    else
      # serial = "2"
      # measureno = 2
      # ch_cd = "CNP"

      @fcdata = AdminFcdata.where(custserial: serial, ch_cd: ch_cd, measureno: measureno).first
      @path = ""
      sub_folder_name = (((1 / 100) * 100) + 100).to_s << "-P"
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

      Rails.logger.info ""
      Rails.logger.info @fcdata.ch_cd
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_UV_")
      AdminFcdata.image_combine(relation: @fcdata, path: @path, type: "F_FM_WH_")

      zip_path = @path.split("/")[0] +"/"+ @path.split("/")[1]
      generate_tgz(relation: @fcdata, path: @path)
    end
  end

  # 개인정보 저장
  def save_privacy_access
    if session[:admin_user] != "user" && !session[:admin_user].nil?
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end

      user = session[:admin_user]
      Rails.logger.info user
      history.id = serial
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.category = "Image Download"
      history.save
    end
  end

  def upload_test
  end
end
