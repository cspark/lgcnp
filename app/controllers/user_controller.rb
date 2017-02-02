require 'iconv'

class UserController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:index]
  before_action :is_admin

  def index
    Rails.logger.info "User count"
    @users = Custinfo.all
    Rails.logger.info @users.count
  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
