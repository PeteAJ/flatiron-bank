Rails.application.routes.draw do

root 'application#index'

resources :accounts, only: [:index, :show, :new, :edit, :create, :update]
resources :clients, only: [:index, :show, :new, :edit, :create, :update]

get 'signup', to: 'sessions#signup'
get 'login', to: 'sessions#login'

post '/clients/:id', to: 'sessions#registrations', as: 'signed-up'
post '/clients/:id', to: 'sessions#sessions', as: 'logged-in'

patch 'accounts/:id', to: 'accounts#update'
patch 'clients/:id', to: 'clients#update'
end
