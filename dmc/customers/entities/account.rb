module Customers
  class Account < Entity

    attribute :oauth_token, String
    attribute :provider, String
    attribute :user_id, String

    def self.build(provider, oauth_token, user_id)
      new.tap do |account|
        account.provider    = provider
        account.oauth_token = oauth_token
        account.user_id     = user_id
      end
    end

  end
end
