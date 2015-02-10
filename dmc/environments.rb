
require_relative 'entities/environment'

require_relative 'forms/environment_form'

require_relative 'serializers/environment_serializer'

require_relative 'repositories/environment_repository'

require_relative 'use_cases/list_environment'
require_relative 'use_cases/create_environment'
require_relative 'use_cases/find_environment'

module Environments
  EnvironmentRepository.register :in_memory, Repository::Adapter::InMemory.new
end
