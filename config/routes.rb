Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :custinfos do
  end
  get "find_user" => "custinfos#find_user"
  get "find_users" => "custinfos#find_users"
  get "update_phone_number" => "custinfos#update_phone_number"
  get "update_agreement" => "custinfos#update_agreement"

  resources :fcinterviews do
  end

  resources :fcposs do
  end

  resources :fcdatas do
  end
  get "get_before_fcdata_count" => "fcdatas#get_before_fcdata_count"
  get "check_yanus_status" => "fcdatas#check_yanus_status"
  get "face_data" => "fcdatas#face_data"
  get "face_data_existed" => "fcdatas#face_data_existed"


  resources :fctabletinterviews do
  end
  get "find_interviews" => "fctabletinterviews#find_interviews"
  post "update_interviews" => "fctabletinterviews#update_interviews"
  post "fctabletinterviews_quickmode" => "fctabletinterviews#fctabletinterviews_quickmode"
  post "fctabletinterviews_update_lots" => "fctabletinterviews#fctabletinterviews_update_lots"
  get "is_update" => "update#is_update"
end
