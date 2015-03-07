require_relative 'environments/repositories/environment_repository'
require_relative 'environments/repositories/environment_repository/in_memory'
require_relative 'environments/repositories/environment_repository/sequel'

require_relative 'environments/entities/environment'

require_relative 'environments/forms/environment_form'
require_relative 'environments/forms/heroku_form'
require_relative 'environments/forms/rubygem_form'
require_relative 'environments/forms/factory_form'

require_relative 'environments/serializers/environment_serializer'

require_relative 'environments/errors/name_taken_error'

require_relative 'environments/use_cases/list_for_project'
require_relative 'environments/use_cases/paginate_for_project'
require_relative 'environments/use_cases/create'
require_relative 'environments/use_cases/update'
require_relative 'environments/use_cases/find'
require_relative 'environments/use_cases/find_by_name'

module Environments
  EnvironmentRepository.register :in_memory,  EnvironmentRepository::InMemory.new
  EnvironmentRepository.register :sequel, EnvironmentRepository::Sequel.new
end
