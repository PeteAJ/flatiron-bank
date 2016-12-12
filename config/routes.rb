Rails.application.routes.draw do

devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'}, :controllers => { registrations: 'registrations', :omniauth_callbacks => "callbacks" }


# devise_scope :user do
#   get "/" => "devise/sessions#new"
# end
#
#
# devise_scope :user do
#   root to: "users/sessions#new"
# end

resources :accounts, only: [:index, :show, :new, :edit, :create, :update]
resources :clients, only: [:index, :show, :new, :edit, :create, :update]

root to: "users/sessions#new"

end
