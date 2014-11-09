class FindOrCreateUser < Struct.new(:provider, :form)

  def run!
    form.validate!

    authorize!

    oauth_token = provider_service.fetch_token form.code

    account = begin
      Repo.query :account, oauth_token: oauth_token
    rescue
      user_provider = provider_service.user(oauth_token)

      Account.create do |account|
        account.oauth_token = oauth_token
        account.user = User.new do |user|
          user.name  = user_provider.name
          user.email = user_provider.email
          user.api_key = SecureRandom.uuid
        end
      end
    end

    account.user
  end

  private

  def authorize!
    unless Dmc::PROVIDERS.include? provider.to_sym
      raise PermissionDeniedError, "Provider #{provider} is not allowed"
    end
  end

  def provider_service
    @provider_service ||= "#{provider.classify}Service".constantize
  end
end
