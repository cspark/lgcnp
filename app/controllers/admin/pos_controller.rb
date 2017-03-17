class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @search = ""
    @params_filter = params[:select_filter]

    @select_filter = []
    if !@params_filter.blank?
      @params_filter.split(',').each do |filter|
        @select_filter << filter
      end
    end

    if params.has_key?(:search) && params[:search].length != 0
      if Rails.env.production? || Rails.env.staging?
        @search = params[:search]
      else
        @search = URI.decode(params[:search]) if !params[:search].blank?
      end
      users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{@search}%").order("lastanaldate desc")
      user_custserials = []
      users.each do |user|
        user_custserials.push(user.custserial)
      end
      @fcpos = Fcpos.where(custserial: user_custserials)
    else
      @fcpos = Fcpos.all.order("uptdate desc")
    end

    if @select_filter == []
      @excel_name = ["이름","채널구분","전면/좌/우측면","분석 일","분석 횟수","업데이트 일","이마 영역정보x","이마 영역정보y","이마 영역정보w","이마 영역정보h","코 영역정보x","코 영역정보y","코 영역정보w","코 영역정보h",
      "우측 눈가 영역정보x","우측 눈가 영역정보y","우측 눈가 영역정보w","우측 눈가 영역정보h","우측 눈밑 영역정보x","우측 눈밑 영역정보y","우측 눈밑 영역정보w","우측 눈밑 영역정보h","좌측 눈가 영역정보x","좌측 눈가 영역정보y","좌측 눈가 영역정보w","좌측 눈가 영역정보h",
      "좌측 눈밑 영역정보x","좌측 눈밑 영역정보y","좌측 눈밑 영역정보w","좌측 눈밑 영역정보h","우측 볼 영역정보x","우측 볼 영역정보y","우측 볼 영역정보w","우측 볼 영역정보h","좌측 볼 영역정보x","좌측 볼 영역정보y","좌측 볼 영역정보w","좌측 볼 영역정보h",
      "우측눈 사각영역 정보l","우측눈 사각영역 정보t","우측눈 사각영역 정보r","우측눈 사각영역 정보b","좌측눈 사각영역 정보l","좌측눈 사각영역 정보t","좌측눈 사각영역 정보r","좌측눈 사각영역 정보b","입 사각영역 정보l","입 사각영역 정보t","입 사각영역 정보r","입 사각영역 정보b",
      "우측 얼굴 끝 라인 좌표x","우측 얼굴 끝 라인 좌표y","좌측 얼굴 끝 라인 좌표x","좌측 얼굴 끝 라인 좌표y"]
    else
      # @fcpos = @fcpos.select("custserial,ch_cd,faceno,measuredate,measureno,uptdate," +@params_filter)
      @excel_name = ["이름","채널구분","전면/좌/우측면","분석 일","분석 횟수","업데이트 일"]
      @select_filter.each do |filter|
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
