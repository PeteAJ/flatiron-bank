require "./config/environment"
require "./app/models/client"

class SessionsController < ApplicationController

  def signup
    end

  def registrations
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
    else
    @client = Client.new(params)
    if @client.save
    session[:client_id] = @client.id
    else
    flash[:notice] = "Please enter name, email and password."
    end
      end
    end





    def login
    end

    def sessions
    client = Client.find_by_email(params[:email])
    if client && client.authenticate(params[:password])
    session[:client_id] = client.id
    redirect to "/clients/#{client.id}"
    else
    flash[:notice] = "Please enter email and password."
    redirect '/login'
      end
    end






    def logout
    logout
    end

    def client_index
    end
end
