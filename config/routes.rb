Rails.application.routes.draw do
  devise_for :users
  root to: "lists#index"
  $date = Time.now.to_s
end
