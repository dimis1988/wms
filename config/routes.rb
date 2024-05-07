Rails.application.routes.draw do
  get 'carts/show'

  namespace :admin do
    root 'admin#index'
    resources :products
    resources :product_categories
    resources :users
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'pages#home'
  get '/about', to: 'pages#about'
  resources :products, only: [:index, :show]
  resources :product_categories
  resources :line_items
  resources :carts

  get "up" => "rails/health#show", as: :rails_health_check

end
