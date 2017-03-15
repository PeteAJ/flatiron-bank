class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  helper_method :current_client
  helper_method :validate_overdraft_transaction
  helper_method :logout
  helper_method :require_login
  before_filter :authenticate_user!






def index
  render '/users/sign_in'
end



def validate_overdraft_transaction(origin_account, new_balance, account_id=nil)
  if !origin_account.overdraft_protection && new_balance < 0
    flash[:notice] = "Withdrawl rejected - insufficient funds!"
    if !account_id
      redirect to "/accounts"
    else
      redirect to "/accounts/#{account_id}"
    end
  end
end


def logout
  session.clear
end

def require_login
  return head(:forbidden) unless session.include? :client_id
end

private
  def logged_in?
    !!current_user
  end

  def current_client
    @current_client ||= Client.find_by_id(session[:client_id]) if session[:client_id] != nil
  end

  def authenticate_user
    if !logged_in?
      redirect_to new_client_signup_path
    end
  end

end
