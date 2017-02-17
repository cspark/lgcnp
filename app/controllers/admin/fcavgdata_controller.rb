class Admin::FcavgdataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @select_option = params[:select]
    temp_age = @select_option
    @fcavgdatas_list = Fcavgdata.all.where("age LIKE '%" + temp_age+ "%'")
    Rails.logger.info @fcavgdatas_list.count
  end
end
