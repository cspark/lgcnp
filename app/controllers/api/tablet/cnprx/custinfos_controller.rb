require 'securerandom'

class Api::Tablet::Cnprx::CustinfosController < Api::ApplicationController
  def index
    custinfos = Custinfo.all
    render json: api_hash_for_list(custinfos), status: :ok
  end

  def get_api_key
    render json: { api_key: "5I04JE4EMH" }, status: :ok
  end

  def find_user
    name = params[:name]
    Rails.logger.info "Find User!"
    Rails.logger.info name
    yy = params[:birthyy]
    mm = params[:birthmm]
    dd = params[:birthdd]
    phone = params[:phone]

    ch_cd = "CNP"
    if params.has_key?(:ch_cd)
      ch_cd = params[:ch_cd]
    end
    find_user = Custinfo.where(custname: name).where(birthyy: yy).where(birthmm: mm).where(birthdd: dd).where(phone: phone).where(ch_cd: ch_cd).first
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

    ch_cd = "CNP"
    if params.has_key?(:ch_cd)
      ch_cd = params[:ch_cd]
    end

    find_users = Custinfo.where(custname:name).where(birthyy:yy).where(birthmm:mm).where(birthdd:dd).where(ch_cd: ch_cd)
    if find_users.present?
      render json: api_hash_for_list(find_users), status: 200
    else
      render json: "", status: 404
    end
  end

  def update_phone_number
      phone = params[:phone]
      serial = params[:serial]

      ch_cd = "CNP"
      if params.has_key?(:ch_cd)
        ch_cd = params[:ch_cd]
      end

      custinfo = Custinfo.where(custserial: serial).where(ch_cd: ch_cd).first
      custinfo.phone = phone
      if custinfo.save
        render json: custinfo.to_api_hash, status: 200
      else
        render json: "", status: 404
      end
  end

  def update_name
      name = params[:name]
      serial = params[:serial]

      ch_cd = "CNP"
      if params.has_key?(:ch_cd)
        ch_cd = params[:ch_cd]
      end

      custinfo = Custinfo.where(custserial: serial).where(ch_cd: ch_cd).first
      custinfo.custname = name
      if custinfo.save
        render json: custinfo.to_api_hash, status: 200
      else
        render json: "", status: 404
      end
  end

  def update_after_service
      is_agree_after = params[:is_agree_after_service]
      tablet_interview_id = params[:tabletInterviewId]
      serial = params[:serial]

      ch_cd = "CNP"
      if params.has_key?(:ch_cd)
        ch_cd = params[:ch_cd]
      end

      custinfo = Custinfo.where(custserial: serial).where(ch_cd: ch_cd).first
      custinfo.is_agree_after = is_agree_after
      if custinfo.save
        begin
          fc = Fctabletinterview.where(custserial: custinfo.custserial).where(tablet_interview_id: tablet_interview_id).first
          fc.is_agree_after = custinfo.is_agree_after
          fc.save
        rescue
        end
        render json: custinfo.to_api_hash, status: 200
      else
        render json: "", status: 404
      end
  end

  def update_email
      email = params[:email]
      gene_barcode = params[:gene_barcode]
      serial = params[:serial]

      ch_cd = "CNP"
      if params.has_key?(:ch_cd)
        ch_cd = params[:ch_cd]
      end

      custinfo = Custinfo.where(custserial: serial).where(ch_cd: ch_cd).first
      if params.has_key?(:email)
        custinfo.email = email
      end

      if params.has_key?(:gene_barcode)
        custinfo.gene_barcode = gene_barcode
      end

      if custinfo.save
        render json: custinfo.to_api_hash, status: 200
      else
        render json: "", status: 404
      end
  end

  def update_agreement
      is_agree_marketing = params[:is_agree_marketing]
      is_agree_thirdparty_info = params[:is_agree_thirdparty_info]
      serial = params[:serial]

      ch_cd = "CNP"
      if params.has_key?(:ch_cd)
        ch_cd = params[:ch_cd]
      end

      custinfo = Custinfo.where(custserial: serial).where(ch_cd: ch_cd).first
      custinfo.is_agree_marketing = is_agree_marketing
      custinfo.is_agree_thirdparty_info = is_agree_thirdparty_info
      if custinfo.save
        render json: custinfo.to_api_hash, status: 200
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
    is_agree_privacy = params[:is_agree_privacy]
    is_agree_thirdparty_info = params[:is_agree_thirdparty_info]
    is_agree_marketing = params[:is_agree_marketing]
    is_agree_after = params[:is_agree_after]
    n_cust_id = params[:n_cust_id]

    time = Time.new
    uptdate = time.year.to_s + "/" + time.month.to_s + "/" + time.day.to_s

    custinfo = Custinfo.new
    custinfo.custserial = Custinfo.all.order('custserial ASC').last.custserial + 1

    ch_cd = "CNP"
    if params.has_key?(:ch_cd)
      ch_cd = params[:ch_cd]
    end

    custinfo.ch_cd = ch_cd
    custinfo.custname = name
    custinfo.is_agree_privacy = "T"
    custinfo.is_agree_thirdparty_info = is_agree_thirdparty_info
    custinfo.is_agree_marketing = is_agree_marketing
    custinfo.is_agree_after = is_agree_after
    custinfo.sex = sex
    custinfo.age = age
    custinfo.birthyy = birthyy
    custinfo.birthmm = birthmm
    custinfo.birthdd = birthdd
    custinfo.phone = phone
    custinfo.uptdate = uptdate
    custinfo.n_cust_id = n_cust_id

    # custinfo.save
    if custinfo.save
      render json: custinfo.to_api_hash, status: 200
    else
      render json: "", status: 404
    end
  end
end