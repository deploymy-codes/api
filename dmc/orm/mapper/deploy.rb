Perpetuity.generate_mapper_for Deploy::Project do
  attribute :name, type: String
  attribute :remote_name, type: String
  attribute :url, type: String
  attribute :user_id, type: String
  attribute :environments
end

Perpetuity.generate_mapper_for Deploy::Environment do
  attribute :name, type: String
  attribute :strategy, type: String
end
