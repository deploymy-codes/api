module Customers
  class UpdateOrCreateAccount < Struct.new(:user, :provider, :oauth_token)

    def run!
      AccountRepository.save retrieve_or_build_account
    end


    def retrieve_or_build_account
      account = AccountRepository.find_by_provider_and_user_id!(provider, user.id)
      account.oauth_token = oauth_token

      account
    rescue AccountRepository::UnknownProviderForUserError
      Account.build(provider, oauth_token, user.id)
    end

  end
end
