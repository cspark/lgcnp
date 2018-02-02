class Admin::GeneinterviewController < Admin::AdminApplicationController
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
      history.category = "FcgeneInterview"
      history.save
    end

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @start_date = "2017-01-25"
    @end_date = Date.today
    @today = Date.today

    select_sex = params[:select_sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    name = params[:name]
    custserial = params[:custserial]
    start_birthyy = params[:start_birthyy]
    end_birthyy = params[:end_birthyy]
    start_birthmm = params[:start_birthmm]
    end_birthmm = params[:end_birthmm]
    gene_barcode = params[:gene_barcode]

    @select_sex = select_sex
    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @name = name
    @custserial = custserial
    @start_birthyy = start_birthyy
    @end_birthyy = end_birthyy
    @start_birthmm = start_birthmm
    @end_birthmm = end_birthmm
    @gene_barcode = gene_barcode

    @is_init = true
    @is_init = false if params[:select_sex].present?

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "BEAU").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "BEAU").order("birthyy asc").first
    end
    if !min_age_custinfo.nil? && !max_age_custinfo.nil?
      @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
      @max_age = Time.current.year - max_age_custinfo.birthyy.to_i

      @min_birthyy = min_age_custinfo.birthyy
      @max_birthyy = max_age_custinfo.birthyy
    end
    @min_birthmm = 1
    @max_birthmm = 12

    @fcgene_interviews = []
    scoped = FcgeneInterview.where(ch_cd: @ch_array).order("uptdate desc")
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(uptdate) >= ? AND to_date(uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(gene_barcode: @gene_barcode) if !@gene_barcode.blank?

    scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil? && !@name.blank?
    scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sex}%") if @select_sex != "all" && !@select_sex.blank?
    if !@start_age.blank? && !@end_age.blank?
      start_birthyy = Time.current.year.to_i - @start_age.to_i
      end_birthyy = Time.current.year.to_i - @end_age.to_i
      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
    end

    scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", @start_birthyy, @end_birthyy) if !@start_birthyy.blank? && !@end_birthyy.blank?
    scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthmm) >= ? AND to_number(custinfo.birthmm) < ?", @start_birthmm, @end_birthmm) if !@start_birthmm.blank? && !@end_birthmm.blank?

    @fcgene_interviews = scoped
    @fcgene_interviews_excel = @fcgene_interviews
    @count = @fcgene_interviews.count
    @fcgene_interviews = Kaminari.paginate_array(@fcgene_interviews).page(params[:page]).per(5)
  end

  def gene_and_genstory_list_beau
    # asdf
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
      history.category = "FcgeneInterview"
      history.save
    end

    @is_admin_init = false
    if (session[:admin_user]['role'] == "admin" || session[:admin_user] == "user") && !params.has_key?(:select_channel)
      @is_admin_init = true
    end

    @start_date = "2017-01-25"
    @end_date = Date.today
    @today = Date.today

    select_sex = params[:select_sex]
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_age = params[:start_age]
    end_age = params[:end_age]
    name = params[:name]
    custserial = params[:custserial]
    start_birthyy = params[:start_birthyy]
    end_birthyy = params[:end_birthyy]
    start_birthmm = params[:start_birthmm]
    end_birthmm = params[:end_birthmm]
    gene_barcode = params[:gene_barcode]

    @select_sex = select_sex
    @start_date = start_date if !start_date.blank?
    @end_date = end_date  if !end_date.blank?
    @start_age = start_age if !start_age.blank?
    @end_age = end_age if !end_age.blank?
    @name = name
    @custserial = custserial
    @start_birthyy = start_birthyy
    @end_birthyy = end_birthyy
    @start_birthmm = start_birthmm
    @end_birthmm = end_birthmm
    @gene_barcode = gene_barcode

    @is_init = true
    @is_init = false if params[:select_sex].present?
    @is_flag = nil
    @is_flag = params[:is_flag] if !params[:is_flag].blank?

    @filtering = ""
    if !params.has_key?(:filtering) || params[:filtering].blank?
      @filtering = "filter_all_gene filter_all_skin filter_all_hair filter_all_mouth filter_all_tired filter_all_climacteric filter_all_born"
    else
      @filtering = params[:filtering]
    end

    ch_cd = ""
    shop_cd = ""
    ch_cd = params[:select_channel] if !params[:select_channel].nil? && params[:select_channel] != "ALL"
    shop_cd = params[:select_shop]
    @shop_cd = shop_cd if !shop_cd.blank?
    @ch_cd = ch_cd

    @ch_array = []
    ch_cd.split(",").each do |channel|
      @ch_array.push(channel)
    end

    if !Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first.nil?
      min_age_custinfo = Custinfo.where(ch_cd: @ch_array).where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: @ch_array).order("birthyy asc").first
    else
      min_age_custinfo = Custinfo.where(ch_cd: "BEAU").where.not(birthyy: nil).order("birthyy desc").first
      max_age_custinfo = Custinfo.where(ch_cd: "BEAU").order("birthyy asc").first
    end
    if !min_age_custinfo.nil? && !max_age_custinfo.nil?
      @min_age = Time.current.year - min_age_custinfo.birthyy.to_i
      @max_age = Time.current.year - max_age_custinfo.birthyy.to_i

      @min_birthyy = min_age_custinfo.birthyy
      @max_birthyy = max_age_custinfo.birthyy
    end
    @min_birthmm = 1
    @max_birthmm = 12

    @fcgene_interviews = []
    scoped = FcgeneInterview.where(ch_cd: @ch_array)
    scoped = scoped.where(shop_cd: @shop_cd) if !@shop_cd.blank?
    temp_end_date = @end_date.to_date + 1.day
    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.where("to_date(fcgene_interview.uptdate) >= ? AND to_date(fcgene_interview.uptdate) < ?", @start_date.to_date, temp_end_date)
    end
    scoped = scoped.where(custserial: @custserial) if !@custserial.blank?
    scoped = scoped.where(gene_barcode: @gene_barcode) if !@gene_barcode.blank?

    if Rails.env.production? || Rails.env.staging?
      scoped = scoped.joins("INNER JOIN fcdata ON (fcdata.flag LIKE '#{@is_flag}')") if !@is_flag.nil? && @is_flag != "T,F"
    end

    scoped = scoped.joins(:custinfo).where("custinfo.custname LIKE ?", "%#{@name}%") if !@name.nil? && !@name.blank?
    scoped = scoped.joins(:custinfo).where("custinfo.sex LIKE ?", "%#{@select_sex}%") if @select_sex != "all" && !@select_sex.blank?
    if !@start_age.blank? && !@end_age.blank?
      start_birthyy = Time.current.year.to_i - @start_age.to_i
      end_birthyy = Time.current.year.to_i - @end_age.to_i
      scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", end_birthyy, start_birthyy)
    end

    scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthyy) >= ? AND to_number(custinfo.birthyy) < ?", @start_birthyy, @end_birthyy) if !@start_birthyy.blank? && !@end_birthyy.blank?
    scoped = scoped.joins(:custinfo).where("to_number(custinfo.birthmm) >= ? AND to_number(custinfo.birthmm) < ?", @start_birthmm, @end_birthmm) if !@start_birthmm.blank? && !@end_birthmm.blank?

    scoped = scoped.order("fcgene_interview.uptdate desc") if Rails.env.production? || Rails.env.staging?

    @fcgene_interviews = scoped
    @fcgene_interviews_excel = @fcgene_interviews
    @count = @fcgene_interviews.count
    @fcgene_interviews = Kaminari.paginate_array(@fcgene_interviews).page(params[:page]).per(5)
  end

  def show
    @interview = FcgeneInterview.where(custserial: params[:userId], ch_cd: params[:ch_cd], measureno: params[:measureno]).first
  end

  def show_interview
  end
end
