Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :full_name
      String :username
      String :email
      String :avatar_url
      String :api_key
    end

    create_table(:accounts) do
      primary_key :id
      String :oauth_token
      String :provider
      Integer :user_id
    end
  end

  down do
    drop_table(:users)
    drop_table(:accounts)
  end
end
