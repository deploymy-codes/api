Perpetuity.generate_mapper_for Projects::Project do
  collection 'projects'

  attribute :name, type: String
  attribute :remote_name, type: String
  attribute :url, type: String
  attribute :user_id, type: String
end
