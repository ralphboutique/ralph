Rails.application.routes.draw do
  # devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Articulos routes
  namespace :admin do
    resources :articles, except: [:show] do
      collection do
        get 'search', to: 'articulos#search', as: 'search'
      end
      member do
        get 'delete', to: 'articulos#destroy', as: 'delete'
      end
    end
  end
  get '/', to: 'catalogue#index', as: 'catalogue'
  get 'Ralp_boutque/products', to: 'catalogue#products', as: 'products'
  get 'Ralp_boutque/product/detail/:id', to: 'catalogue#details', as: 'details'
  get '/cart', to: 'cart#show'
  post '/cart/add', to: 'cart#add_item'
  delete '/cart/remove', to: 'cart#remove_item'
  # resources :articles
  # Defines the root path route ("/")
  # root "posts#index"
end
