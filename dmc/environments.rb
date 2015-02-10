require_relative 'environments/entities/environment'

require_relative 'environments/forms/create_form'

require_relative 'environments/serializers/environment_serializer'

require_relative 'environments/repositories/environment_repository'
require_relative 'environments/repositories/adapter/in_memory'
require_relative 'environments/repositories/adapter/perpetuity'

require_relative 'environments/use_cases/list'
require_relative 'environments/use_cases/create'
require_relative 'environments/use_cases/find'

module Environments
  EnvironmentRepository.register :in_memory, Repository::Adapter::InMemory.new
end
