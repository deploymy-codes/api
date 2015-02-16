Sequel.migration do
  up do
    create_table(:deployments) do
      primary_key :id
      String :commit
      Integer :environment_id
      String :log
      String :state
    end
  end

  down do
    drop_table(:deployments)
  end
end
