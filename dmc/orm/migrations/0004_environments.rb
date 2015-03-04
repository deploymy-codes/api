Sequel.migration do
  up do
    create_table(:environments) do
      primary_key :id
      String :name
      Integer :project_id
      String :strategy
      String :heroku_api_key
      String :heroku_app_name
      String :rubygem_api_key
    end
  end

  down do
    drop_table(:environments)
  end
end
