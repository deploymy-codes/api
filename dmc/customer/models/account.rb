module Customer
  class Account
    include Entity

    attr_accessor :oauth_token, :provider, :user
  end
end
