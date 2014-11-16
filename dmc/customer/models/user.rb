module Customer
  class User
    include Entity

    attr_accessor :name, :email, :api_key, :accounts
  end
end
