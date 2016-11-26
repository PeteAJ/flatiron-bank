Rails.application.routes.draw do

  root 'application#index', as: 'index'
resources :accounts, :clients, :sessions
end
