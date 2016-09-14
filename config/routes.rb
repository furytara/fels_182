Rails.application.routes.draw do
  root "sessions#new"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "lessons" => "lessons#index"

  namespace :admin do
    resources :categories
    resources :words
  end
  resources :users
  resources :relationships, only: [:index, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories do
    resources :lessons
  end
  resources :results
  resources :words, only: [:index]
end

