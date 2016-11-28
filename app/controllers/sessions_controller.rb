class SessionsController < ApplicationController

  def signup
    end

  def registrations
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      render "signup"
    else
    @client = Client.new(params)
    if @client.save
    session[:client_id] = @client.id
    redirect_to "/accounts_path"
    else
    flash[:notice] = "Please enter name, email and password."
      render "signup"
    end
      end
    end





    def login
    end

    def sessions
    client = Client.find_by_email(params[:email])
    if client && client.authenticate(params[:password])
    session[:client_id] = client.id
    redirect_to "/client_path"
    else
    flash[:notice] = "Please enter email and password."
    redirect_to '/login'
      end
    end






    def logout
    logout
    end

    def client_index
    end
end
