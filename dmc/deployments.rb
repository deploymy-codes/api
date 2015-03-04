require 'interchange'
require 'octokit'
require 'platform-api'
require 'gems'

require_relative 'deployments/lib/command_runner'

require_relative 'deployments/entities/deployment'
require_relative 'deployments/entities/log'

require_relative 'deployments/serializers/deployment_serializer'
require_relative 'deployments/serializers/log_serializer'

require_relative 'deployments/forms/create_form'
require_relative 'deployments/forms/log_form'

require_relative 'deployments/repositories/deployment_repository'
require_relative 'deployments/repositories/deployment_repository/in_memory'
require_relative 'deployments/repositories/deployment_repository/sequel'

require_relative 'deployments/repositories/log_repository'
require_relative 'deployments/repositories/log_repository/in_memory'
require_relative 'deployments/repositories/log_repository/sequel'

require_relative 'deployments/services/github_service'
require_relative 'deployments/services/github_service/octokit_github_service'
require_relative 'deployments/services/github_service/fake_github_service'

require_relative 'deployments/services/heroku_service'
require_relative 'deployments/services/heroku_service/api_heroku_service'
require_relative 'deployments/services/heroku_service/fake_heroku_service'

require_relative 'deployments/services/rubygem_service'
require_relative 'deployments/services/rubygem_service/api_rubygem_service'
require_relative 'deployments/services/rubygem_service/fake_rubygem_service'

require_relative 'deployments/jobs/deploy_job'

require_relative 'deployments/use_cases/create'
require_relative 'deployments/use_cases/create_release'
require_relative 'deployments/use_cases/paginate_for_environment'
require_relative 'deployments/use_cases/deploy'
require_relative 'deployments/use_cases/find'
require_relative 'deployments/use_cases/find_by_id_and_environment'
require_relative 'deployments/use_cases/create_log'
require_relative 'deployments/use_cases/update_log'
require_relative 'deployments/use_cases/list_log'

module Deployments
  DeploymentRepository.register :in_memory, DeploymentRepository::InMemory.new
  DeploymentRepository.register :sequel, DeploymentRepository::Sequel.new

  LogRepository.register :in_memory, LogRepository::InMemory.new
  LogRepository.register :sequel, LogRepository::Sequel.new

  HerokuService.register :fake, FakeHerokuService.new
  HerokuService.register :api, ApiHerokuService.new

  GithubService.register :fake,    FakeGithubService.new
  GithubService.register :octokit, OctokitGithubService.new

  RubygemService.register :fake, FakeRubygemService.new
  RubygemService.register :api, ApiRubygemService.new
end
