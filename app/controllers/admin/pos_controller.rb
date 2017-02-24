class Admin::PosController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @search = ""
    if params.has_key?(:search) && params[:search].length != 0
      @search = params[:search]
      users = Custinfo.where(ch_cd: "CNP").where("custname LIKE ?", "%#{params[:search]}%").order("lastanaldate desc")
      user_custserials = []
      users.each do |user|
        user_custserials.push(user.custserial)
      end
      @fcpos = Fcpos.where(custserial: user_custserials)
    else
      @fcpos = Fcpos.all.order("uptdate desc")
    end

    @fcpos_excel = @fcpos
    @fcpos = Kaminari.paginate_array(@fcpos).page(params[:page]).per(3)

    respond_to do |format|
      format.html
      format.xls
    end
  end
end
