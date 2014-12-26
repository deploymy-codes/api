Perpetuity.generate_mapper_for Customer::User do
  attribute :name
  attribute :email
  attribute :api_key
  attribute :accounts

  index :api_key
end

Perpetuity.generate_mapper_for Customer::Account do
  attribute :oauth_token
  attribute :provider

  index :oauth_token
end
