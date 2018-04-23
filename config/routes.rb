Rails.application.routes.draw do
  get 'user/new'
  post 'user/new', to: 'user#create'
  get 'user/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
