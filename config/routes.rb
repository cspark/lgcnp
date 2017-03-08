Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    get "/"  => "admin#index"
    get "admin_login"  => "admin#admin_login"
    post "admin_login"  => "admin#login"
    delete "admin_logout" => "admin#logout"

    get "user_list"  => "user#index"
    get "users/detail"  => "user#show"
    get "feedback"  => "feedback#index"
    get "feedback_list"  => "feedback#list"
    get "feedbacks/detail"  => "feedback#show"
    get "tabletinterview" => "tabletinterview#index"
    get "tabletinterview/detail" => "tabletinterview#show"

    get "after_interview" => "fcafterinterviews#show"
    get "after_interview_1" => "fcafterinterviews#show_1"
    post "update_after_interview" => "fcafterinterviews#update"
    delete "after_interview" => "fcafterinterviews#delete"
    get "fcavg_list" => "fcavgdata#list"
    get "data_list" => "data#list"
    get "data/detail" => "data#show"
    get "fcpos_list" => "pos#list"
    get "fcpos/detail" => "pos#show"
    get "fcschedule_list" => "schedule#list"
    get "fcschedule/detail" => "schedule#show"
    get "image_list" => "image#index"
    get "image/detail" => "image#show"
    resources :admin_users do
    end
  end

  namespace :api do
    namespace :beau do
      resources :beau_user do
        collection do
          get 'lcare_user_list'
          put 'measure_update'
        end
      end
      resources :beau_fcdata do
      end
      resources :beau_fcinterview do
      end
      resources :beau_fcpos do
      end
      resources :beau_fcavgdata do
      end
      resources :beau_lcare_user do
        collection do
          get 'lcare_integrated_user_list'
        end
      end
    end

    namespace :cnp do
      resources :cnp_user do
        collection do
          get 'lcare_user_list'
          put 'measure_update'
        end
      end
      resources :cnp_fcdata do
      end
      resources :cnp_fcinterview do
      end
      resources :cnp_fcpos do
      end
      resources :cnp_fcavgdata do
      end
    end

    namespace :schedule do
      resources :fcshop do
      end
      resources :fcschedule do
        collection do
          get 'month_list'
          get 'today_list'
          put 'update_reservation'
        end
      end
    end

    namespace :admin do
      resources :admin_lcare_user do
        collection do
          get 'lcare_integrated_user_list'
        end
      end
    end

  end

  get "get_api_key" => "custinfos#get_api_key"
  get "find_user" => "custinfos#find_user"
  get "find_users" => "custinfos#find_users"
  get "update_phone_number" => "custinfos#update_phone_number"
  get "update_name" => "custinfos#update_name"
  get "update_email" => "custinfos#update_email"
  get "update_after_service" => "custinfos#update_after_service"
  get "update_agreement" => "custinfos#update_agreement"


  resources :custinfos do
  end

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
  post "update_interviews_just_refund" => "fctabletinterviews#update_interviews_just_refund"
  post "fctabletinterviews_quickmode" => "fctabletinterviews#fctabletinterviews_quickmode"
  post "fctabletinterviews_update_lots" => "fctabletinterviews#fctabletinterviews_update_lots"
  get "is_update" => "update#is_update"

  #Related Admin
  get 'calculate' => 'fctabletinterviews#calculate'
end
