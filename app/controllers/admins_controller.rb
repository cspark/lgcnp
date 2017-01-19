class AdminsController < ApplicationController
  skip_before_action :authenticate

  def index
    if session[:currnet_user] == nil
      redirect_to "/admin_login"
    end
  end

  def admin_login
    if params.has_key(:login_id)
      login_id = params[:login_id]
      password = params[:password]
      if login_id == "admin" && password == "admin"
        redirect_to "/"
      end
    else
      render 'admins/login'
    end
  end
end
