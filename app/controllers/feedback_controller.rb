class FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:index]
  before_action :is_admin

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @date_1days_ago = (@date - 1.days).strftime("%F")
    @date_2weeks_ago = (@date - 2.weeks).strftime("%F")
    @date_3months_ago = (@date - 3.months).strftime("%F")
    if Rails.env.production? || Rails.env.staging?
      @tablet_interviews_1_days_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", (Date.today.to_s))
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((Date.today - 2.weeks).to_s))
      @tablet_interviews_3_months_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((Date.today - 3.months).to_s))
    else
      @tablet_interviews_1_days_ago = Fctabletinterview.all
      @tablet_interviews_2_weeks_ago = Fctabletinterview.all
      @tablet_interviews_3_months_ago = Fctabletinterview.all
    end
  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
