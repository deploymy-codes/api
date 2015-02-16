require 'interchange'

require_relative 'deployments/entities/deployment'

require_relative 'deployments/serializers/deployment_serializer'

require_relative 'deployments/forms/create_form'

require_relative 'deployments/repositories/deployment_repository'
require_relative 'deployments/repositories/deployment_repository/in_memory'
require_relative 'deployments/repositories/deployment_repository/sequel'

require_relative 'deployments/jobs/deploy_job'

require_relative 'deployments/use_cases/create'
require_relative 'deployments/use_cases/list'
require_relative 'deployments/use_cases/deploy'
require_relative 'deployments/use_cases/find'

module Deployments
  DeploymentRepository.register :in_memory,  DeploymentRepository::InMemory.new
  DeploymentRepository.register :sequel, DeploymentRepository::Sequel.new
end
