class UserSerializer < ActiveModel::Serializer
  attributes :api_key, :email, :name
end
