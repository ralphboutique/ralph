Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Articulos routes
  # namespace :admin do
  #   resources :articles, except: [:show] do
  #     collection do
  #       get 'search', to: 'articulos#search', as: 'search'
  #     end
  #     member do
  #       get 'delete', to: 'articulos#destroy', as: 'delete'
  #     end
  #   end
  # end
  get '/categories', to: 'categories#show', as: 'show_category'
  get 'categories/new', to: 'categories#new', as: 'new_category'
  post 'categories/create', to: 'categories#create', as: 'create_category'
  delete 'categories/:id/delete', to: 'categories#destroy', as: 'delete_category'
  get '/categories/:id/edit', to: 'categories#edit', as: 'edit_category'
  patch '/categories/:id', to: 'categories#update', as: 'update_category'
  get 'search/warehouses', to: 'categories#search', as: 'search_category'

  get '/sizes', to: 'sizes#show', as: 'show_size'
  get 'sizes/new', to: 'sizes#new', as: 'new_size'
  post 'sizes/create', to: 'sizes#create', as: 'create_size'
  delete 'sizes/:id/delete', to: 'sizes#destroy', as: 'delete_size'
  get '/sizes/:id/edit', to: 'sizes#edit', as: 'edit_size'
  patch '/sizes/:id', to: 'sizes#update', as: 'update_size'
  get 'search/warehouses', to: 'sizes#search', as: 'search_size'

  get '/articles', to: 'articles#index', as: 'index'
  get '/admin', to: 'articles#dashboard', as: 'admin'
  get 'article/new', to: 'articles#new', as: 'new'
  post 'article/create', to: 'articles#create', as: 'create'
  delete 'article/:id/delete', to: 'articles#destroy', as: 'delete_article'
  get '/articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  patch '/articles/:id', to: 'articles#update', as: 'update_article'
  get 'search/articles', to: 'articles#search', as: 'search_article'
  patch '/articles/:id/toggle_status', to: 'articles#toggle_status', as: 'toggle_status'

  get '/warehouses', to: 'warehouses#show', as: 'show_warehouses'
  get 'warehouses/new', to: 'warehouses#new', as: 'new_warehouses'
  post 'warehouses/create', to: 'warehouses#create', as: 'create_warehouses'
  delete 'warehouses/:id/delete', to: 'warehouses#destroy', as: 'delete_warehouses'
  get '/warehouses/:id/edit', to: 'warehouses#edit', as: 'edit_warehouses'
  patch '/warehouses/:id', to: 'warehouses#update', as: 'update_warehouses'
  get 'search/warehouses', to: 'warehouses#search', as: 'search_warehouses'

  get '/users', to: 'user#show', as: 'show_user'
  get 'users/new', to: 'user#new', as: 'new_user'
  post 'users/create', to: 'user#create', as: 'create_user'
  delete 'users/:id/delete', to: 'user#destroy', as: 'delete_user'
  get '/users/:id/edit', to: 'user#edit', as: 'edit_user'
  patch '/users/:id', to: 'user#update', as: 'update_user'
  get 'search/users', to: 'user#search', as: 'search_user'
  patch '/user/:id/toggle_status', to: 'user#toggle_status', as: 'toggle_status_user'

  # this routes are used for catalogue
  get '/ralpboutique', to: 'catalogue#index', as: 'catalogue'
  get 'Ralp_boutque/categories', to: 'catalogue#categories', as: 'categories'
  get 'Ralp_boutque/products', to: 'catalogue#products', as: 'products'
  get 'Ralp_boutque/product/detail/:id', to: 'catalogue#details', as: 'details'
  get '/cart', to: 'cart#show'
  post '/cart/add', to: 'cart#add_item'
  delete '/cart/remove', to: 'cart#remove_item'

  get '/roles', to: 'roles#show', as: 'show_roles'
  get 'roles/new', to: 'roles#new', as: 'new_roles'
  post 'roles/create', to: 'roles#create', as: 'create_roles'
  delete 'roles/:id/delete', to: 'roles#destroy', as: 'delete_roles'
  get '/roles/:id/edit', to: 'roles#edit', as: 'edit_roles'
  patch '/roles/:id', to: 'roles#update', as: 'update_roles'
  get 'search/roles', to: 'roles#search', as: 'search_roles'

  get '/inventary', to: 'inventary#index', as: 'index_inventary'
  get '/generate_pdf', to: 'inventary#generate_pdf', as: 'generate_pdf'

  get'/direct_sales', to: 'direct_sales#index', as: 'direct_sales'
  get'/direct_sales/new', to: 'direct_sales#new', as: 'new_direct_sales'
  post '/direct_sales/create', to: 'direct_sales#create', as: 'create_direct_sales'
 
  get'/credit_sales', to: 'credit_sales#index', as: 'credit_sales'
  get'/credit_sales/new', to: 'credit_sales#new', as: 'new_credit_sales'
  post '/credit_sales/create', to: 'credit_sales#create', as: 'create_credit_sales'
  put '/credit_sales/cancel/:id', to: 'credit_sales#cancel', as:'cancel_credit_sales'
  put '/credit_sales/:id/pay_installment', to: 'credit_sales#pay_installment', as: 'pay_installment'

  # Defines the root path route ("/")
  root "catalogue#index"
end
