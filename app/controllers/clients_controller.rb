class ClientsController < ApplicationController
  before_action :set_client, except: [:create, :index, :new]
  before_action :authenticate_user!, except: [:create, :new]
  before_action :admin_only, only: :destroy
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    current_client == current_user
    unless current_user.admin?
    unless @client == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  end

  # GET /clients/new
  def new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create

    @client = Client.find_or_initialize_by(email: params[:email])
    @client.update(password: params[:password])
    redirect_to client_path(id: @client.id)
  end
    #respond_to do |format|
    #  if @client.save
    #    format.html { redirect_to @client, notice: 'Client was successfully created.' }
    #    format.json { render :show, status: :created, location: @client }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @client.errors, status: :unprocessable_entity }
    #  end
    #end


  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    if @client.update_attributes(client_params)
     redirect_to clients_path, :notice => "User updated."
   else
     redirect_to clients_path, :alert => "Unable to update user."
   end
 end



    #respond_to do |format|
    #  if @client.update(client_params)
    #    format.html { redirect_to @client, notice: 'Client was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @client }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @client.errors, status: :unprocessable_entity }
    #  end
    #end



  private
    # Use callbacks to share common setup or constraints between actions.
    def admin_only
      current_client == current_user
      unless current_user.admin? || @client == current_user
     redirect_to clients_path, :alert => "Access denied."
   end
  end


    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:role)

    end
end
