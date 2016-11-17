require 'securerandom'

class CustinfosController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def index
    custinfos = Custinfo.all
    render json: api_hash_for_list(custinfos), status: :ok
  end

#이름 + 생년월일로 검색
  def find_user
    name = params[:name]
    yy = params[:birthyy]
    mm = params[:birthmm]
    dd = params[:birthdd]

    find_user = Custinfo.where(custname:name).where(birthyy:yy).where(birthmm:mm).where(birthdd:dd).first
    if find_user.present?
      render json: find_user.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
  end

  def find_users
    name = params[:name]
    yy = params[:birthyy]
    mm = params[:birthmm]
    dd = params[:birthdd]

    find_users = Custinfo.where(custname:name).where(birthyy:yy).where(birthmm:mm).where(birthdd:dd)
    if find_users.present?
      render json: api_hash_for_list(find_users), status: 200
    else
      render json: "", status: 404
    end
  end

  def create
    Rails.logger.info "TEST!!"
    Rails.logger.info params.inspect
    name = params[:name]
    sex = params[:sex]
    age = params[:age]
    birthyy = params[:birthyy]
    birthmm = params[:birthmm]
    birthdd = params[:birthdd]
    phone = params[:phone]
    time = Time.new
    uptdate = time.year.to_s + "/" + time.month.to_s + "/" + time.day.to_s

    custinfo = Custinfo.new
    custinfo.SERIAL = SecureRandom.random_number(9999999999999999999999999999999999999999)
    custinfo.CUSTNAME = name
    custinfo.SEX = sex
    custinfo.AGE = age
    custinfo.BIRTHYY = birthyy
    custinfo.BIRTHMM = birthmm
    custinfo.BIRTHDD = birthdd
    custinfo.PHONE = phone
    custinfo.UPTDATE = uptdate

    custinfo.save

    #temp value
    #uptdate = "2015/12/31"
    generate_random_data(custinfo.SERIAL, uptdate)

  end

  def generate_random_data(inputserial, inputuptdate)
    fcdata = Fcdata.new
    fcdata.CUSTSERIAL = inputserial
    fcdata.UPTDATE = inputuptdate
    fcdata.input_random_number
    fcdata.save

    fcpos = Fcpos.new
    fcpos.CUSTSERIAL = inputserial
    fcpos.UPTDATE = inputuptdate
    fcpos.input_random_number
    fcpos.save

    fcinterview = Fcinterview.new
    fcinterview.CUSTSERIAL = inputserial
    fcinterview.UPTDATE = inputuptdate
    fcinterview.save

    fctabletinterview = Fctabletinterview.new
    fctabletinterview.CUSTSERIAL = inputserial
    fctabletinterview.save

    render :text => inputserial

  end
end
