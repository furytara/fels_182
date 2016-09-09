Rails.application.routes.draw do
  root             "sessions#new"
  namespace :admin do
    resources :categories
    resources :words
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
