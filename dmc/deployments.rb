require 'interchange'

require_relative 'deployments/entities/deployment'

require_relative 'deployments/serializers/deployment_serializer'

require_relative 'deployments/forms/create_form'

require_relative 'deployments/repositories/deployment_repository'
require_relative 'deployments/repositories/deployment_repository/in_memory'
require_relative 'deployments/repositories/deployment_repository/perpetuity'

require_relative 'deployments/use_cases/create'
require_relative 'deployments/use_cases/list'

module Deployments
  DeploymentRepository.register :in_memory,  DeploymentRepository::InMemory.new
  DeploymentRepository.register :perpetuity, DeploymentRepository::Perpetuity.new
end
