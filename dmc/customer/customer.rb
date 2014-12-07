require 'octokit'
require 'interchange'

require_relative 'entities/account'
require_relative 'entities/user'
require_relative 'entities/repository_provider'

require_relative 'serializers/user_serializer'
require_relative 'serializers/repository_provider_serializer'

require_relative 'repositories/user_repository'
require_relative 'repositories/adapter/in_memory'

require_relative 'forms/code_form'
require_relative 'forms/api_key_form'

require_relative 'services/github_service'
require_relative 'services/github_service/octokit_github_service'
require_relative 'services/github_service/fake_github_service'

require_relative 'services/git_service'
require_relative 'services/git_service/rugged_git_service'
require_relative 'services/git_service/fake_git_service'

require_relative 'use_cases/find_or_create_user'
require_relative 'use_cases/find_user'
require_relative 'use_cases/list_repositories'

module Customer
  PROVIDERS = [:github]

  UserRepository.register :in_memory, Repository::Adapter::InMemory.new
  GithubService.register  :fake,      FakeGithubService.new
  GitService.register     :fake,      FakeGitService.new
end
