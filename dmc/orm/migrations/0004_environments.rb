Sequel.migration do
  up do
    create_table(:environments) do
      primary_key :id
      String  :name
      Integer :project_id
      String  :type
      String  :api_key
      String  :app_name
    end
  end

  down do
    drop_table(:environments)
  end
end
