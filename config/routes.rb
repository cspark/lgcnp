Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images do
    collection do
      get 'type_image_download'
    end
  end

  resources :update do
    collection do
      get 'update_launcher_download'
      post 'update_launcher_upload'
    end
  end

  namespace :admin do
    get "manager_2017"  => "admin#index"
    get "admin_login"  => "admin#admin_login"
    post "admin_login"  => "admin#login"
    post "check_access"  => "admin#check_access"
    delete "admin_logout" => "admin#logout"
    get "access_restriction"  => "admin#access_restriction"
    get "fcmodecnt" => "user#fcmodecnt"
    get "privacy_access_history" => "privacy#index"
    get "save_privacy_access_image" => "image#save_privacy_access"

    get "user_list"  => "user#index"
    get "users/detail"  => "user#show"
    get "users/edit"  => "user#edit"
    get "input_cnp"  => "feedback#index"
    get "input_cnpr"  => "feedback#input_cnpr"
    get "feedback_list_cnp"  => "feedback#list"
    get "feedback_list_cnpr"  => "feedback#cnpr_list"
    get "feedbacks/detail"  => "feedback#show"
    get "feedbacks/cnpr_detail"  => "feedback#cnpr_show"
    get "cnp_interview" => "tabletinterview#index"
    get "cnpr_interview" => "tabletinterview#cnpr_list"
    get "beau_interview" => "tabletinterview#beau_list"
    get "geneinterview" => "geneinterview#list"
    get "geneinterview/detail"  => "geneinterview#show"
    get "geneinterview/show_interview"  => "geneinterview/show_interview"
    get "tabletinterview/detail" => "tabletinterview#show"
    get "tabletinterview/beau_detail" => "tabletinterview#beau_show"
    get "tabletinterview/edit" => "tabletinterview#edit"
    get "tabletinterview/filter_check" => "tabletinterview#filter_check"
    get "tabletinterview/cnpr_filter_check" => "tabletinterview#cnpr_filter_check"
    get "tabletinterview/cnpr_detail" => "tabletinterview#cnpr_show"
    get "tabletinterview/cnpr_edit" => "tabletinterview#cnpr_edit"
    get "tabletinterview/show_cnp_interview" => "tabletinterview#show_cnp_interview"
    get "tabletinterview/show_beau_interview" => "tabletinterview#show_beau_interview"
    get "tabletinterview/show_cnpr_interview" => "tabletinterview#show_cnpr_interview"

    get "after_interview" => "fcafterinterviews#show"
    get "after_interview_1" => "fcafterinterviews#show_1"
    post "update_after_interview" => "fcafterinterviews#update"
    delete "after_interview" => "fcafterinterviews#delete"

    get "rx_after_interview" => "fcafterinterviewrxes#show"
    get "rx_after_interview_1" => "fcafterinterviewrxes#show_1"
    get "create_rx_after_interview_1" => "fcafterinterviewrxes#create_show_1"
    post "update_rx_after_interview" => "fcafterinterviewrxes#update"
    delete "rx_after_interview" => "fcafterinterviewrxes#delete"
    get "fcavg_list" => "fcavgdata#list"
    get "data_list_cnp" => "data#list"
    get "data_list_cnpr" => "data#cnpr_list"
    get "data_list_beau" => "data#beau_list"
    get "data/detail" => "data#show"
    get "data/filter_check" => "data#filter_check"
    get "fcpos_list" => "pos#list"
    get "fcpos/detail" => "pos#show"
    get "fcpos/filter_check" => "pos#filter_check"
    get "fcschedule_list" => "schedule#list"
    get "fcschedule/detail" => "schedule#show"
    get "image_list" => "image#index"
    get "image/detail" => "image#show"
    get "upload_test" => "image#upload_test"

    get "manager_list" => "manager#index"
    get "allow_list" => "allowaccess#index"

    resources :user do
    end

    resources :tabletinterview do
    end

    resources :admin_users do
    end
    resources :manager do
      collection do
        get 'add_manager'
        get 'edit_manager'
        get 'login_history'
        post 'duplication'
        post 'update'
        post 'delete'
      end
    end
    resources :allowaccess do
      collection do
        get 'add_access_range'
        get 'edit_access_range'
        post 'update'
        post 'delete'
      end
    end
  end

  namespace :api do
    namespace :beau do
      resources :beau_user do
        collection do
          get 'lcare_user_list'
          put 'measure_update'
          put 'gene_barcode_update'
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
      resources :beau_fcmodecnt do
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
      resources :schedule_fcshop do
      end
      resources :schedule_fcschedule do
        collection do
          get 'month_list'
          get 'today_list'
          put 'update_reservation'
          delete 'delete_schedule'
        end
      end
    end

    namespace :admin do
      resources :admin_lcare_user do
        collection do
          get 'lcare_integrated_user_list'
        end
      end
      resources :admin_user do
      end
      resources :admin_fcdata do
      end
      resources :admin_fcshop do
      end
    end

    namespace :gene_interview do
      resources :gene_interview do
        collection do
          put 'update'
        end
      end
    end

    #CNP RX
    namespace :tablet do
      namespace :cnprx do
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

        resources :fctabletinterviewrxes do
        end
        get "find_lcare_user" => "fctabletinterviewrxes#find_lcare_user"
        get "find_n_cust_id" => "fctabletinterviewrxes#find_n_cust_id"
        get "find_interviewrxes" => "fctabletinterviewrxes#find_interviews"
        post "update_interviewrxes" => "fctabletinterviewrxes#update_interviews"
        post "update_interviewrxes_just_refund" => "fctabletinterviewrxes#update_interviews_just_refund"
        post "fctabletinterviewrxes_quickmode" => "fctabletinterviewrxes#fctabletinterviews_quickmode"
        post "fctabletinterviewrxes_update_lots" => "fctabletinterviewrxes#fctabletinterviews_update_lots"
        get "is_update" => "update#is_update"
        post "interview_count_increase" => "fctabletinterviewrxes#interview_count_increase"
        post "create_afterinterviewrx" => "fctabletinterviewrxes#create_afterinterviewrx"
        post "update_afterinterviewrx" => "fctabletinterviewrxes#update_afterinterviewrx"

        #Related Admin
        get 'calculate' => 'fctabletinterviewrxes#calculate'
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
