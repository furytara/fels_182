Rails.application.routes.draw do
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  root "users#index"
  namespace :admin do
    resources :categories
    resources :words
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories do
    resources :lessons
  end
  resources :results
  resources :words, only: [:index]
end
