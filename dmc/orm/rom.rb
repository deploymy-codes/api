require 'rom-sql'

setup = ROM.setup(sqlite: "sqlite::memory")

setup.sqlite.connection.create_table(:users) do
  primary_key :id
  String :name
  String :email
  String :api_key
end

setup.sqlite.connection.create_table(:accounts) do
  primary_key :id
  Integer :user_id
  String :oauth_token
  String :provider
end

ROM_SETUP = setup.finalize
