Perpetuity.generate_mapper_for Deploy::Project do
  collection 'projects'

  attribute :name, type: String
  attribute :remote_name, type: String
  attribute :url, type: String
  attribute :user_id, type: String
  attribute :environments
end

Perpetuity.generate_mapper_for Deploy::Environment do
  collection 'environments'

  attribute :name, type: String
  attribute :strategy, type: String
end
