Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  # users/registrationsコントローラのnew_addressアクション、create_addressアクションとして振る舞うということ？
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: "lists#index"

  resources :categories, except: :new
  resources :lists do
    collection do
      get "list_search"
      get "task_search"
    end

    resources :goals do
      member do
        delete "image_destroy"
        # 既存リソースの更新なのでpatchを使用
        post "change_status"
        post "change_status_at_root", defaults: {format: 'json'}
      end
      collection do
        get "task_search_in_list"
      end
    end

  end

end
