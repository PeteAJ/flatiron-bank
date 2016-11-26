require './config/environment'


class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    #@accounts = Account.all
    if logged_in?
      @accounts = current_client.accounts
    else
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if logged_in?
      @account = Account.find_by_id(params[:id])
      @transactions = current_client.transactions
      if @account && @account.client == current_client
    else
      end
    end
  end

  # GET /accounts/new
  def new
    #@account = Account.new
  end

  # GET /accounts/1/edit
  def edit
      @account = Account.find_by_id(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    #@account = Account.new(account_params)
    if params[:initial_deposit].to_i < 50
      else
    @account = Account.create(name: params[:name], :overdraft_protection => params[:overdraft_protection])
    @account.balance = params[:initial_deposit]
    @account.client_id = current_client.id
    @account.save

    #respond_to do |format|
    #  if @account.save
    #    format.html { redirect_to @account, notice: 'Account was successfully created.' }
    #    format.json { render :show, status: :created, location: @account }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @account.errors, status: :unprocessable_entity }
    #  end
    #end
  end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    @account = Account.find_by_id(params[:id])
    @account.name = params[:name]
    @account.save

    #respond_to do |format|
    #  if @account.update(account_params)
    #    format.html { redirect_to @account, notice: 'Account was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @account }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @account.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find_by_id(params[:id])
    @account.destroy
    #respond_to do |format|
    #  format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end



  def new_transaction
    if logged_in?
    account = Account.find_by_id(params[:id])
    if account.client == current_client
      #transaction = account.transactions.create(description: params[:transaction_type], amount: params[:transaction_amount])
        transaction = account.create_transaction(params[:transaction_type], params[:transaction_amount].to_i)
        if transaction.description == 'withdrawl'
          new_balance = account.balance - params[:transaction_amount].to_i
          if account.overdraft_protection
             if new_balance.between?(-200,0)
               new_balance = new_balance - 25
             elsif new_balance < -200
              flash[:notice] = "transaction rejected"

             end
          end
          validate_overdraft_transaction(account, new_balance, account.id)
        elsif transaction.description == 'deposit'
          new_balance = account.balance + params[:transaction_amount].to_i
        end
        account.update(balance: new_balance)
    else
    end
    end
    end

  def transfer
    if logged_in?
    origin_account = current_client.accounts.find_by(name: params[:account_from_name])
    destination_account = current_client.accounts.find_by(name: params[:account_to_name])

    if origin_account && destination_account && origin_account.name != destination_account.name
      # transfer
      new_balance = origin_account.balance - params[:transaction_amount].to_i
      origin_account.balance -= params[:transaction_amount].to_i
      destination_account.balance += params[:transaction_amount].to_i


      validate_overdraft_transaction(origin_account, new_balance)
      origin_account.save
      destination_account.save
      flash[:notice] = "*transaction successful"
    else
      flash[:notice] = "*transaction not completed. please enter valid account names.*"
    end
    else
    end
    end

  def outside_transfer
      if logged_in?
        origin_account = current_client.accounts.find_by(name: params[:account_from_name])
        client = Client.find_by_email(params[:account_to_email])
        destination_account = client.accounts.find_by(name: params[:account_to_name])

    if origin_account && destination_account
      transaction = destination_account.transactions.create(amount: params[:transaction_amount].to_i)
      new_balance = origin_account.balance - transaction.amount
      origin_account.balance -= transaction.amount
      destination_account.balance += transaction.amount
      validate_overdraft_transaction(origin_account, new_balance)
      origin_account.save
      destination_account.save
      flash[:notice] = "*transaction successful*"
    else
      flash[:notice] = "*transaction not completed. please enter valid account name and email for the user you would like to transfer money to.*"
    end
    else
    end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.fetch(:account, {})
    end
end
