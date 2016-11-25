require './config/environment'
require 'sinatra/flash'


class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
