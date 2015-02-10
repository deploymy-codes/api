Perpetuity.generate_mapper_for Environments::Environment do
  collection 'environments'

  attribute :name, type: String
  attribute :strategy, type: String
  attribute :project_id, type: String
end
