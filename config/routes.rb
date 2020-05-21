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
      get "task_search", defaults: {format: 'json'}
    end

    resources :goals, except: :index do
      member do
        delete "root_destroy"
        delete "image_destroy"
        # 既存リソースの更新なのでpatchを使用
        patch "change_status"
      end
    end

  end

end
