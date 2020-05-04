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

  resources :lists, only: [:new, :create]
  resources :category

  $date = Time.now.to_s

end
