Rails.application.routes.draw do

  root 'events#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :events, only: [:new, :create, :show, :index]
  resources :users, only: [:new, :create, :show]
end
