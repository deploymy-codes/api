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
      find_user
    rescue RecordNotFoundError
      create_user
    end

    def find_user
      UserRepo.find_by_oauth_token oauth_token
    end

    def create_user
      user = build_user

      UserRepo.save user

      user
    end

    def build_account
      User.new.tap do |user|
        account.oauth_token = oauth_token
        account.user = User.new.tap do |user|
          user.name  = user_details.name
          user.email = user_details.email
          user.api_key = SecureRandom.uuid
        end
      end
    end

    def user_details
      @user_provider ||= provider_service.user(oauth_token)
    end

    def oauth_token
      @oauth_token ||= provider_service.fetch_token form.code
    end

    def provider_service
      @provider_service ||= GithubService
    end
  end
end
