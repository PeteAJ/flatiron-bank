class SessionsController < ApplicationController


  def new
  end

  def signup
    end

  def registrations
    return redirect_to(controller: 'sessions', action: 'signup') if
    params[:name].empty? || params[:email].empty? || params[:password].empty?

    @client = Client.new(params[:id])
    if @client.save
    session[:client_id] = @client.id
    redirect_to client_path(@client)
    else
    flash[:notice] = "Please enter name, email and password."
    render "signup"
    end

    end


    def logged_in?
      !!current_client
    end

    def login
   end

   def sessions
   return redirect_to(controller: 'sessions', action: 'login') if
   params[:email].empty? || params[:password].empty?

   client = Client.find_by_email(params[:email])
   return head(:forbidden) unless client.authenticate(params[:password])
   session[:client_id] = client.id
   redirect_to client_path
   end






   def logout
   logout
   end

   def client_index
   end



 end
