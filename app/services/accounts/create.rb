module Accounts
  class Create < DeployMyCodes::Service

    def call
      oauth = params[:oauth]
      return unless oauth.present?

      user = params[:user]

      if user.present?
        repository.add_or_update_account_to(user)
      else
        user = login
        repository.add_or_update_account_to(user)
      end
    end

    private

    def repository
      @user_repository ||= UserRepository.new
    end
  end
end
