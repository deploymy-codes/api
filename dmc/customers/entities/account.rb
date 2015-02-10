module Customers
  class Account < Entity

    attribute :oauth_token, String
    attribute :provider, String
    attribute :user_id, String

    def self.build(provider, oauth_token)
      new.tap do |account|
        account.provider    = provider
        account.oauth_token = oauth_token
      end
    end

  end
end
