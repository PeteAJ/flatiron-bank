Rails.application.routes.draw do

  root 'application#index', as: 'index'
resources :accounts, :clients

get 'signup', to: 'sessions#signup'
get 'login', to: 'sessions#login'

post '/clients/:id', to: 'sessions#sessions'
end
