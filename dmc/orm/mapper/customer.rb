Perpetuity.generate_mapper_for Customer::User do
  attribute :name, type: String
  attribute :email, type: String
  attribute :api_key, type: String
  attribute :accounts

  index :api_key
end

Perpetuity.generate_mapper_for Customer::Account do
  attribute :oauth_token, type: String
  attribute :provider, type: String

  index :oauth_token
end
