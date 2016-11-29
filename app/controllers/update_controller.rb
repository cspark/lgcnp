class UpdateController < ApplicationController
  def is_update
    version_code = params[:version_code]

    current_version_code = 12

    if version_code.to_i < current_version_code.to_i
      url_json = "{'download_url' : 'http://203.247.132.106/app.apk'}"
      render json: url_json.to_json, status: 200
    else
      render json: "", status: 200
    end
  end
end
