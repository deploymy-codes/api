module Customer
  class UserSerializer < Serializer
    attributes :api_key, :email, :name
  end
end
