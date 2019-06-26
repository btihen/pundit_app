Rails.application.routes.draw do
  devise_for :users

  resources :users
  
  # root to: 'home#index'
  root to: 'static_pages#root'
end
