module Customer
  class User
    include Persistence

    attr_accessor :name, :email, :api_key, :accounts
  end
end
