Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about', to:'static_pages#about'
  get '/rule', to:'static_pages#rule'
  get '/setting', to:'static_pages#setting'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/easy_login', to:'sessions#easy_login'

  resources :users
  resources :articles
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
