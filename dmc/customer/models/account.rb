module Customer
  class Account
    include Persistence

    attr_accessor :id, :oauth_token, :user
  end
end
