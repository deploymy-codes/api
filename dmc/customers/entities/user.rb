module Customers
  class User < Entity

    attribute :full_name, String
    attribute :username, String
    attribute :email, String
    attribute :api_key, String
    attribute :avatar_url, String

    def self.build_from_provider_user(provider_user)
      new.tap do |user|
        user.full_name  = provider_user.name
        user.username   = provider_user.login
        user.email      = provider_user.email
        user.avatar_url = provider_user.avatar_url
        user.api_key    = SecureRandom.uuid
      end
    end

  end
end
