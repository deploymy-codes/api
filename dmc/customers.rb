require 'octokit'
require 'interchange'

require_relative 'customers/entities/account'
require_relative 'customers/entities/user'
require_relative 'customers/entities/remote_project'

require_relative 'customers/serializers/user_serializer'
require_relative 'customers/serializers/remote_project_serializer'

require_relative 'customers/repositories/user_repository'
require_relative 'customers/repositories/adapter/in_memory'
require_relative 'customers/repositories/adapter/perpetuity'

require_relative 'customers/forms/code_form'
require_relative 'customers/forms/api_key_form'

require_relative 'customers/services/github_service'
require_relative 'customers/services/github_service/octokit_github_service'
require_relative 'customers/services/github_service/fake_github_service'

require_relative 'customers/use_cases/find_or_create_user'
require_relative 'customers/use_cases/find_user'
require_relative 'customers/use_cases/list_remote_project'
require_relative 'customers/use_cases/get_remote_project'

module Customers
  PROVIDERS = [:github]

  UserRepository.register :in_memory,  Repository::Adapter::InMemory.new
  UserRepository.register :perpetuity, Repository::Adapter::Perpetuity.new
  GithubService.register  :fake,       FakeGithubService.new
end
