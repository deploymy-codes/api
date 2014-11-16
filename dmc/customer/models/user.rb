module Customer
  class User
    include Entity

    attr_accessor :name, :email, :api_key, :accounts

    def self.build_from_provider_user(provider_user)
      new.tap do |user|
        user.name  = user_details.name
        user.email = user_details.email
        user.api_key = SecureRandom.uuid
      end
    end
  end
end
