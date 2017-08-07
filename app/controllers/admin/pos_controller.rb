class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
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
      history.category = "Fcpos"
      history.save
    end

    @search = ""
    @params_filter = params[:select_filter]

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    @ch_cd = params[:select_channel] if !params[:select_channel].nil?

    if params.has_key?(:search) && params[:search].length != 0
      if Rails.env.production? || Rails.env.staging?
        @search = params[:search]
      else
        @search = URI.decode(params[:search]) if !params[:search].blank?
      end

      users = Custinfo.where("custname LIKE ?", "%#{@search}%").order("lastanaldate desc")
      user_custserials = []
      users.each do |user|
        user_custserials.push(user.custserial)
      end
      if @ch_cd != "ALL"
        @fcpos = Fcpos.where(ch_cd: @ch_cd).where(custserial: user_custserials).order("uptdate desc")
      else
        @fcpos = Fcpos.where(custserial: user_custserials).order("uptdate desc")
      end
    else
      if @ch_cd != "ALL"
        @fcpos = Fcpos.where(ch_cd: @ch_cd).order("uptdate desc")
      else
        @fcpos = Fcpos.order("uptdate desc")
      end
    end

    if @select_filter == []
      @excel_name = ["시리얼","이름","채널","측정 부위","진단 날짜","분석 횟수","업데이트 일","이마 영역정보x","이마 영역정보y","이마 영역정보w","이마 영역정보h","코 영역정보x","코 영역정보y","코 영역정보w","코 영역정보h",
      "우측 눈가 영역정보x","우측 눈가 영역정보y","우측 눈가 영역정보w","우측 눈가 영역정보h","우측 눈밑 영역정보x","우측 눈밑 영역정보y","우측 눈밑 영역정보w","우측 눈밑 영역정보h","좌측 눈가 영역정보x","좌측 눈가 영역정보y","좌측 눈가 영역정보w","좌측 눈가 영역정보h",
      "좌측 눈밑 영역정보x","좌측 눈밑 영역정보y","좌측 눈밑 영역정보w","좌측 눈밑 영역정보h","우측 볼 영역정보x","우측 볼 영역정보y","우측 볼 영역정보w","우측 볼 영역정보h","좌측 볼 영역정보x","좌측 볼 영역정보y","좌측 볼 영역정보w","좌측 볼 영역정보h",
      "우측눈 사각영역 정보l","우측눈 사각영역 정보t","우측눈 사각영역 정보r","우측눈 사각영역 정보b","좌측눈 사각영역 정보l","좌측눈 사각영역 정보t","좌측눈 사각영역 정보r","좌측눈 사각영역 정보b","입 사각영역 정보l","입 사각영역 정보t","입 사각영역 정보r","입 사각영역 정보b",
      "우측 얼굴 끝 라인 좌표x","우측 얼굴 끝 라인 좌표y","좌측 얼굴 끝 라인 좌표x","좌측 얼굴 끝 라인 좌표y"]
    else
      @excel_name = ["시리얼","이름","채널구분","측정 부위","진단 날짜","분석 횟수","업데이트 일"]
      @select_filter.each do |filter|
        if filter.include?("fh_x")
          filter = "이마 영역정보x"
        elsif filter.include?("fh_y")
          filter = "이마 영역정보y"
        elsif filter.include?("fh_w")
          filter = "이마 영역정보w"
        elsif filter.include?("fh_h")
          filter = "이마 영역정보h"
        elsif filter.include?("ns_x")
          filter = "코 영역정보x"
        elsif filter.include?("ns_y")
          filter = "코 영역정보y"
        elsif filter.include?("ns_w")
          filter = "코 영역정보w"
        elsif filter.include?("ns_h")
          filter = "코 영역정보h"
        elsif filter.include?("res_x")
          filter = "우측 눈가 영역정보x"
        elsif filter.include?("res_y")
          filter = "우측 눈가 영역정보y"
        elsif filter.include?("res_w")
          filter = "우측 눈가 영역정보w"
        elsif filter.include?("res_h")
          filter = "우측 눈가 영역정보h"
        elsif filter.include?("reu_x")
          filter = "우측 눈밑 영역정보x"
        elsif filter.include?("reu_y")
          filter = "우측 눈밑 영역정보y"
        elsif filter.include?("reu_w")
          filter = "우측 눈밑 영역정보w"
        elsif filter.include?("reu_h")
          filter = "우측 눈밑 영역정보h"
        elsif filter.include?("les_x")
          filter = "좌측 눈가 영역정보x"
        elsif filter.include?("les_y")
          filter = "좌측 눈가 영역정보y"
        elsif filter.include?("les_w")
          filter = "좌측 눈가 영역정보w"
        elsif filter.include?("les_h")
          filter = "좌측 눈가 영역정보h"
        elsif filter.include?("leu_x")
          filter = "좌측 눈밑 영역정보x"
        elsif filter.include?("leu_y")
          filter = "좌측 눈밑 영역정보y"
        elsif filter.include?("leu_w")
          filter = "좌측 눈밑 영역정보w"
        elsif filter.include?("leu_h")
          filter = "좌측 눈밑 영역정보h"
        elsif filter.include?("rs_x")
          filter = "우측 볼 영역정보x"
        elsif filter.include?("rs_y")
          filter = "우측 볼 영역정보y"
        elsif filter.include?("rs_w")
          filter = "우측 볼 영역정보w"
        elsif filter.include?("rs_h")
          filter = "우측 볼 영역정보h"
        elsif filter.include?("ls_x")
          filter = "좌측 볼 영역정보x"
        elsif filter.include?("ls_y")
          filter = "좌측 볼 영역정보y"
        elsif filter.include?("ls_w")
          filter = "좌측 볼 영역정보w"
        elsif filter.include?("ls_h")
          filter = "좌측 볼 영역정보h"
        elsif filter.include?("rt_re_l")
          filter = "우측눈 사각영역 정보 Left"
        elsif filter.include?("rt_re_t")
          filter = "우측눈 사각영역 정보 top"
        elsif filter.include?("rt_re_r")
          filter = "우측눈 사각영역 정보 Right"
        elsif filter.include?("rt_re_b")
          filter = "우측눈 사각영역 정보 Bottom"
        elsif filter.include?("rt_le_l")
          filter = "좌측눈 사각영역 정보 Left"
        elsif filter.include?("rt_le_t")
          filter = "좌측눈 사각영역 정보 top"
        elsif filter.include?("rt_le_r")
          filter = "좌측눈 사각영역 정보 Right"
        elsif filter.include?("rt_le_b")
          filter = "좌측눈 사각영역 정보 Right"
        elsif filter.include?("rt_lip_l")
          filter = "입 사각영역 정보 Left"
        elsif filter.include?("rt_lip_t")
          filter = "입 사각영역 정보 top"
        elsif filter.include?("rt_lip_r")
          filter = "입 사각영역 정보 Right"
        elsif filter.include?("rt_lip_b")
          filter = "입 사각영역 정보 Bottom"
        elsif filter.include?("rt_res_x")
          filter = "우측 얼굴 끝 라인 좌표x"
        elsif filter.include?("rt_res_y")
          filter = "우측 얼굴 끝 라인 좌표y"
        elsif filter.include?("rt_res_w")
          filter = "우측 얼굴 끝 라인 좌표w"
        elsif filter.include?("rt_res_h")
          filter = "우측 얼굴 끝 라인 좌표h"
        else
          filter =  filter
        end
        @excel_name << filter
      end
    end

    @fcpos_excel = @fcpos
    if params.has_key?(:page)
      page = params[:page]
    else
      page = 1
    end
    @fcpos = Kaminari.paginate_array(@fcpos).page(page).per(5)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
    @fcpos = Fcpos.where(custserial: params[:userId], measureno: params[:measureno]).first
  end
end
