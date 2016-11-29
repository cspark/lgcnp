require 'securerandom'

class CustinfosController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def index
    custinfos = Custinfo.all
    render json: api_hash_for_list(custinfos), status: :ok
  end

  def find_user
    name = params[:name]
    Rails.logger.info params[:name]
    yy = params[:birthyy]
    mm = params[:birthmm]
    dd = params[:birthdd]

    find_user = Custinfo.where(custname: name).where(birthyy: yy).where(birthmm: mm).where(birthdd: dd).first
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
    custinfo.custserial = SecureRandom.random_number(999999999999)
    custinfo.custname = name
    custinfo.sex = sex
    custinfo.age = age
    custinfo.birthyy = birthyy
    custinfo.birthmm = birthmm
    custinfo.birthdd = birthdd
    custinfo.phone = phone
    custinfo.update = uptdate

    custinfo.save
    if custinfo.save
      render json: custinfo.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
    #temp value
    #uptdate = "2015/12/31"
    # generate_random_data(custinfo.custserial, uptdate)
  end

  def generate_random_data(inputserial, inputuptdate)
    fcdata = Fcdata.new
    fcdata.custserial = inputserial
    fcdata.update = inputuptdate
    fcdata.input_random_number
    fcdata.save

    fcpos = Fcpos.new
    fcpos.custserial = inputserial
    fcpos.update = inputuptdate
    fcpos.input_random_number
    fcpos.save

    fcinterview = Fcinterview.new
    fcinterview.custserial = inputserial
    fcinterview.update = inputuptdate
    fcinterview.save

    fctabletinterview = Fctabletinterview.new
    fctabletinterview.custserial = inputserial
    fctabletinterview.save

    render :text => inputserial

  end
end
