module Customers
  class FindOrCreateUser < Struct.new(:provider, :form)

    def run!
      form.validate!

      authorize!

      find_user_by_oauth_token!
    rescue UserRepository::UnknownOauthTokenError
      find_or_create_user_by_provider_user
    end

    private

    def authorize!
      unless PROVIDERS.include? provider.to_sym
        raise PermissionDeniedError, "Provider #{provider} is not allowed"
      end
    end

    def find_user_by_oauth_token!
      UserRepository.find_by_oauth_token!(oauth_token)
    end

    def find_or_build_user_by_provider_user
      UserRepository.find_by_email!(provider_user.email)
    rescue UserRepository::UnknownEmailError
      User.build_from_provider_user(provider_user)
    end

    def find_or_create_user_by_provider_user
      user = find_or_build_user_by_provider_user
      user.add_or_update_account(provider, oauth_token)

      UserRepository.save user
      user
    end

    def provider_user
      @provider_user ||= GithubService.user(oauth_token)
    end

    def oauth_token
      @oauth_token ||= GithubService.fetch_token form.code
    end
  end
end
