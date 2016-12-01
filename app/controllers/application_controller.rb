class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper :all
  before_action :require_login




def index
  render '/'
end



end
