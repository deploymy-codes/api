module Customer
  class FindOrCreateUser < Struct.new(:provider, :form)

    def run!
      form.validate!

      authorize!

      find_user_by_oauth_token!
    rescue UserRepo::UnknownOauthTokenError
      find_or_create_user_by_provider_user
    end

    private

    def authorize!
      unless PROVIDERS.include? provider.to_sym
        raise PermissionDeniedError, "Provider #{provider} is not allowed"
      end
    end

    def find_user_by_oauth_token!
      UserRepo.find_by_oauth_token!(oauth_token)
    end

    def find_or_build_user_by_provider_user
      UserRepo.find_by_email!(provider_user.email)
    rescue UserRepo::UnknownEmailError
      User.build_from_provider_user(provider_user)
    end

    def find_or_create_user_by_provider_user
      user = find_or_build_user_by_provider_user
      user.add_or_update_account(provider, oauth_token)

      UserRepo.save user
      user
    end

    def provider_user
      @provider_user ||= provider_service.user(oauth_token)
    end

    def oauth_token
      @oauth_token ||= provider_service.fetch_token form.code
    end

    def provider_service
      @provider_service ||= GithubService
    end
  end
end
