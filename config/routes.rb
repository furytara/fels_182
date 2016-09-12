Rails.application.routes.draw do
  root             "users#index"
  namespace :admin do
    resources :categories
    resources :words
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
