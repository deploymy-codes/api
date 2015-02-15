module Customers
  class UserSerializer < Serializer
    attributes :api_key, :email, :name, :avatar_url
  end
end