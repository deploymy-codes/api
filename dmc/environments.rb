require_relative 'environments/entities/environment'

require_relative 'environments/forms/create_form'

require_relative 'environments/serializers/environment_serializer'

require_relative 'environments/repositories/environment_repository'
require_relative 'environments/repositories/environment_repository/in_memory'
require_relative 'environments/repositories/environment_repository/perpetuity'

require_relative 'environments/use_cases/list'
require_relative 'environments/use_cases/create'
require_relative 'environments/use_cases/find'

module Environments
  EnvironmentRepository.register :in_memory,  EnvironmentRepository::InMemory.new
  EnvironmentRepository.register :perpetuity, EnvironmentRepository::Perpetuity.new
end
