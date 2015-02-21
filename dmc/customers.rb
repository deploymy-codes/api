require 'octokit'
require 'interchange'

require_relative 'customers/entities/account'
require_relative 'customers/entities/user'
require_relative 'customers/entities/remote_project'
require_relative 'customers/entities/remote_organization'

require_relative 'customers/serializers/user_serializer'
require_relative 'customers/serializers/remote_project_serializer'
require_relative 'customers/serializers/remote_organization_serializer'

require_relative 'customers/repositories/user_repository'
require_relative 'customers/repositories/user_repository/in_memory'
require_relative 'customers/repositories/user_repository/sequel'

require_relative 'customers/repositories/account_repository'
require_relative 'customers/repositories/account_repository/in_memory'
require_relative 'customers/repositories/account_repository/sequel'

require_relative 'customers/forms/code_form'
require_relative 'customers/forms/api_key_form'

require_relative 'customers/services/github_service'
require_relative 'customers/services/github_service/octokit_github_service'
require_relative 'customers/services/github_service/fake_github_service'

require_relative 'customers/use_cases/find_or_create'
require_relative 'customers/use_cases/update_or_create_account'
require_relative 'customers/use_cases/find'
require_relative 'customers/use_cases/list_remote_organization'
require_relative 'customers/use_cases/list_remote_organization_project'
require_relative 'customers/use_cases/list_remote_project'
require_relative 'customers/use_cases/get_remote_project'

module Customers
  UserRepository.register :in_memory,  UserRepository::InMemory.new
  UserRepository.register :sequel, UserRepository::Sequel.new

  AccountRepository.register :in_memory,  AccountRepository::InMemory.new
  AccountRepository.register :sequel, AccountRepository::Sequel.new

  GithubService.register :fake,    FakeGithubService.new
  GithubService.register :octokit, OctokitGithubService.new(ENV['OCTOKIT_CLIENT_ID'], ENV['OCTOKIT_CLIENT_SECRET'])
end
