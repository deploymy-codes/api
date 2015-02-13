Perpetuity.generate_mapper_for Deployments::Deployment do
  collection 'deployments'

  attribute :commit, type: String
  attribute :environment_id, type: String
  attribute :log, type: String
  attribute :state, type: String
end
