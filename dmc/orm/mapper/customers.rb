Perpetuity.generate_mapper_for Customers::User do
  collection 'users'

  attribute :name, type: String
  attribute :email, type: String
  attribute :api_key, type: String

  index :api_key
end

Perpetuity.generate_mapper_for Customers::Account do
  collection 'accounts'

  attribute :oauth_token, type: String
  attribute :provider, type: String
  attribute :user_id, type: String

  index :oauth_token
end
