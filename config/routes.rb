Rails.application.routes.draw do
  
  namespace :admin do
    root 'admin#index'
    resources :products
    resources :product_categories
    resources :users
    resources :line_items
    resources :orders do
      member do 
        patch :update_status
      end
    end
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
  resources :orders
  resources :payments, only: [:new, :create]
  post 'payments/create', to: 'payments#create'

  get '/checkout', to: 'checkout#index'
  get '/search', to: 'search#index'


  get "up" => "rails/health#show", as: :rails_health_check

end
