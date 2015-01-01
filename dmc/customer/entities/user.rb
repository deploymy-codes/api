module Customer
  class User < Entity

    attr_accessor :name, :email, :api_key, :accounts

    def initialize
      @accounts = []
    end

    def self.build_from_provider_user(provider_user)
      new.tap do |user|
        user.name    = provider_user.name
        user.email   = provider_user.email
        user.api_key = SecureRandom.uuid
      end
    end

    def find_account(provider)
      accounts.find { |account| account.provider == provider.to_s }
    end

    def add_or_update_account(provider, oauth_token)
      account = find_account(provider)

      if account.nil?
        accounts << Account.build(provider, oauth_token)
      else
        account.oauth_token = oauth_token
      end
    end
  end
end
