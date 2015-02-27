Sequel.migration do
  up do
    create_table(:deployments) do
      primary_key :id
      String :sha
      Integer :environment_id
      String :release
      String :state
    end

    create_table(:logs) do
      primary_key :id
      Integer :deployment_id
      String :name
      Integer :duration
      String :stdout, text: true
    end
  end

  down do
    drop_table(:deployments)
    drop_table(:logs)
  end
end
