Sequel.migration do
  up do
    create_table(:projects) do
      primary_key :id
      String :name
      Integer :remote_id
      String :url
      Integer :user_id
    end
  end

  down do
    drop_table(:projects)
  end
end
