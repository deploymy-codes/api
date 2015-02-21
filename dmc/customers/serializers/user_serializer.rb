module Customers
  class UserSerializer < Serializer
    attributes :api_key, :email, :full_name, :avatar_url, :username
  end
end
