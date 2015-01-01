module Customer
  class Account < Entity

    attr_accessor :oauth_token, :provider

    def self.build(provider, oauth_token)
      new.tap do |account|
        account.provider    = provider
        account.oauth_token = oauth_token
      end
    end

  end
end
