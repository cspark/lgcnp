class Admin::FcavgdataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    if params.has_key?(:isExcel) && params[:isExcel]
      history = Privacyaccesshistory.new
      serial = 1
      if Privacyaccesshistory.count > 1
        serial = Privacyaccesshistory.order("id desc").first.id.to_i + 1
      end
      user = session[:admin_user] if session[:admin_user] != "user" && !session[:admin_user].nil?
      history.id = serial
      history.adminuser_id = user['id']
      history.email = user['email']
      history.ip = session[:ip].to_s
      history.save
    end

    @select_option = params[:select]

    if @select_option.blank?
      @select_option = "ALL"
    end

    @fcavgdatas_list = Fcavgdata.all.where("age LIKE ?", "%#{@select_option}%")

    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end
