class FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:index]
  before_action :is_admin

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    if Rails.env.production? || Rails.env.staging?
      @tablet_interviews_1_days_ago = Fctabletinterview.where("to_date(uptdate) >= ? AND to_date(uptdate) <= ?", (Date.today - 2.days), (Date.today))
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where("to_date(uptdate) >= ? AND to_date(uptdate) <= ?", (Date.today - 2.weeks - 1.days), (Date.today - 2.weeks + 1.days))
      @tablet_interviews_3_months_ago = Fctabletinterview.where("to_date(uptdate) >= ? AND to_date(uptdate) <= ?", (Date.today - 3.months - 1.days), (Date.today - 3.months + 1.days))
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
