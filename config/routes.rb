Rails.application.routes.draw do
  root "static_pages#home"
  resources :users
  namespace :admin do
    resources :categories
  end
end
