Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :custinfos do
  end
  get "find_user" => "custinfos#find_user"
  get "find_users" => "custinfos#find_users"

  resources :fcinterviews do
  end

  resources :fcposs do
  end

  resources :fcdatas do
  end
  get "check_yanus_status" => "fcdatas#check_yanus_status"
  get "find_history" => "fcdatas#find_histroy"
  get "face_data" => "fcdatas#face_data"

  resources :fctabletinterviews do
  end
  get "find_interviews" => "fctabletinterviews#find_interviews"
  post "update_interviews" => "fctabletinterviews#update_interviews"

  get "is_update" => "update#is_update"
end
