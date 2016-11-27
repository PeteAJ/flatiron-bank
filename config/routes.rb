Rails.application.routes.draw do

  root 'application#index', as: 'index'
resources :accounts, :clients

get 'signup', to: 'sessions#signup'
get 'login', to: 'sessions#login'

post '/', to: 'sessions#registrations'
post '/', to: 'sessions#sessions'

end
