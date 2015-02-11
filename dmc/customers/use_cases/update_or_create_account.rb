module Customers
  class UpdateOrCreateAccount < Struct.new(:user, :provider, :oauth_token)

    def run!
      begin
        account = AccountRepository.find_by_provider_and_user_id!(provider, user.id)
        account.oauth_token = oauth_token
      rescue AccountRepository::UnknownProviderForUserError
        account = Account.build(provider, oauth_token)
      end
      account.user_id     = user.id

      AccountRepository.save account
    end

  end
end
