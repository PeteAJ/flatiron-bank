Rails.application.routes.draw do

  root 'application#index', as: 'index'


  resources :application
  resources :clients
  resources :accounts
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
