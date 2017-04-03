class Admin::AdminApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  protected

  # def is_admin
  #   if session[:admin_user] == nil
  #     redirect_to '/admin/admin_login'
  #   end
  # end
end
