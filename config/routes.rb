Rails.application.routes.draw do

  # devise/registrationsからusers/registrationsに変更するため
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  # users/registrationsコントローラのnew_addressアクション、create_addressアクションとして振る舞うということ？
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: "lists#index"

  resources :users, except: [:index] do
    member do
      delete "avatar_destroy"
      get "confirm_destroy"
    end
    resources :addresses, only: [:edit, :update]
  end


  resources :categories, except: :new
  resources :lists do
    collection do
      get "list_search"
      get "task_search"
    end
    member do
      post "change_favorite"
    end
    resources :goals do
      member do
        delete "image_destroy"
        # 既存リソースの更新なのでpatchを使用
        post "change_status"
        post "change_status_at_root", defaults: {format: 'json'}
        post "reset"
      end
      collection do
        get "task_search_in_list"
      end
      resources :steps, only: [:edit, :update, :destroy] do
        member do
          post "change_status", defaults: {format: 'json'}
          delete "destroy_image"
          post "reset"
        end
        resources :practices, only: [:edit, :update, :destroy] do
          member do
            post "change_status", defaults: {format: 'json'}
            delete "destroy_image"
            post "reset"
          end
        end
      end
    end
  end

end
