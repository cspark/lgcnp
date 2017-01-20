Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :custinfos do
  end
  get "get_api_key" => "custinfos#get_api_key"
  get "find_user" => "custinfos#find_user"
  get "find_users" => "custinfos#find_users"
  get "update_phone_number" => "custinfos#update_phone_number"
  get "update_name" => "custinfos#update_name"
  get "update_email" => "custinfos#update_email"
  get "update_after_service" => "custinfos#update_after_service"
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

  #Related Admin
  get 'admin' => 'admins#index'
  post 'login' => 'admins#admin_login'
  get 'admin_login' => 'admins#admin_login'
  get 'show_feedback' => 'admins#show_feedback'

  get 'calculate' => 'Fctabletinterview#calculate'
end
