class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate

  def api_hash_for_list(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash)
      end
    end
  end

  def api_hash_for_user_list(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash_for_yanus)
      end
    end
  end

  def api_hash_for_fcdata_month_list(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash_for_fcdata_month_list)
      end
    end
  end

  def api_hash_for_list_fcdata_join_custinfo(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash_for_list_fcdata_join_custinfo)
      end
    end
  end

  def api_hash_for_list_has_encrypted_pw(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash_has_encrypted_pw)
      end
    end
  end

  protected
  def authenticate
    if request.headers['Authorization'] != "5I04JE4EMH"
      authenticate_token
    end
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
    end
  end

end
