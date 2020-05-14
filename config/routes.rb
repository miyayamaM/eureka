# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about', to: 'static_pages#about'
  get '/rule', to: 'static_pages#rule'
  get '/contact', to: 'static_pages#contact'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/easy_login', to: 'sessions#easy_login'
  get 'tags/:tag', to: 'articles#index', as: :tag
  get '/result', to: 'articles#result'

  resources :users do
    member do
      get :following, :followers, :bookmarks
    end
  end

  resources :articles do
    resources :bookmarks, only: [:create]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :relationships, only: %i[create destroy]
  resources :bookmarks, only: [:destroy]
end
