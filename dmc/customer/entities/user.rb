module Customer
  class User < Entity

    attribute :name, String
    attribute :email, String
    attribute :api_key, String
    attribute :accounts, Array[Account]

    def self.build_from_provider_user(provider_user)
      new.tap do |user|
        user.name    = provider_user.name
        user.email   = provider_user.email
        user.api_key = SecureRandom.uuid
      end
    end

    def find_account(provider)
      accounts.find { |account| account.provider == provider }
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
