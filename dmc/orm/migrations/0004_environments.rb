Sequel.migration do
  up do
    create_table(:environments) do
      primary_key :id
      String :name
      Integer :project_id
      String :strategy
    end
  end

  down do
    drop_table(:environments)
  end
end
