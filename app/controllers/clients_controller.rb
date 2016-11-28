class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    #@clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find_by_id(params[:id])
    if params[:account]
    @account = Account.find_by_id(params[:account][:id])
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
      @client = Client.find_by_id(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    #respond_to do |format|
    #  if @client.save
    #    format.html { redirect_to @client, notice: 'Client was successfully created.' }
    #    format.json { render :show, status: :created, location: @client }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @client.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client = Client.find_by_id(params[:id])
    @client.email = params[:email]
    @client.save
    #respond_to do |format|
    #  if @client.update(client_params)
    #    format.html { redirect_to @client, notice: 'Client was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @client }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @client.errors, status: :unprocessable_entity }
    #  end
    #end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :password_digest)

    end
end
