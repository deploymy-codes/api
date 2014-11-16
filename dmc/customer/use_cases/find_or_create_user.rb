module Customer
  class FindOrCreateUser < Struct.new(:provider, :form)

    def run!
      form.validate!

      authorize!

      find_or_create_user
    end

    private

    def authorize!
      unless PROVIDERS.include? provider.to_sym
        raise PermissionDeniedError, "Provider #{provider} is not allowed"
      end
    end

    def find_or_create_user
      find_user_by_oauth_token!
    rescue UserRepo::UnknownOauthTokenError
      build_user

      user
    end

    def find_user_by_oauth_token!
      UserRepo.find_by_oauth_token!(oauth_token)
    end

    def create_user
      user = build_user

      UserRepo.save user

      user
    end

    def build_user
      User.build_from_provider_user(provider_user)
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
