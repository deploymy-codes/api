module Accounts
  class Create < DeployMyCodes::Service

    def call
      user = repository.find_by :user, email: params[:email]

      if user.nil?
        user = repository.build :user, user_params
      end

      account = user.accounts.find { |a| a.is?(params[:provider]) }

      if account.nil?
        account = repository.build :account, account_params
        user.accounts << account
        repository.save(user)
      else
        repository.update_attributes_of account, account_params
      end

      user
    end

    private

    def user_params
      { email: params[:email], first_name: params[:first_name], last_name: params[:last_name] }
    end

    def account_params
      { provider: params[:provider], oauth_token: params[:oauth_token] }
    end

  end
end
