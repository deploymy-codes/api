require_relative 'environments/entities/environment'

require_relative 'environments/forms/environment_form'

require_relative 'environments/serializers/environment_serializer'

require_relative 'environments/repositories/environment_repository'
require_relative 'environments/repositories/adapter/in_memory'
require_relative 'environments/repositories/adapter/perpetuity'

require_relative 'environments/use_cases/list_environment'
require_relative 'environments/use_cases/create_environment'
require_relative 'environments/use_cases/find_environment'

module Environments
  EnvironmentRepository.register :in_memory, Repository::Adapter::InMemory.new
end
