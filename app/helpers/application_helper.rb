module ApplicationHelper

        def logged_in?
          session[:client_id]
        end

        def current_client
        Client.find(session[:client_id])
        helper_method :current_client
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

end
