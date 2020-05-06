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

  resources :categories
  resources :lists do
    resources :goals
  end


  $date = Time.now.to_s

end
