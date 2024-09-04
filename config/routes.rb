Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Articulos routes
  get '/articles', to: 'articulos#index', as: 'index'
  get 'article/new', to: 'articulos#new', as: 'new'
  post 'article/create', to: 'articulos#create', as: 'create'
  get 'article/:id/delete', to: 'articulos#destroy', as: 'delete_article'
  get '/articles/:id/edit', to: 'articulos#edit', as: 'edit_article'
  patch '/articles/:id', to: 'articulos#update', as: 'update_article'
  get 'search/articles', to: 'articulos#search', as: 'search_article'
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
