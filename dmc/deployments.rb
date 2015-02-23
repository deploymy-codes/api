require 'interchange'
require 'octokit'
require 'platform-api'

require_relative 'deployments/entities/deployment'

require_relative 'deployments/serializers/deployment_serializer'

require_relative 'deployments/forms/create_form'

require_relative 'deployments/repositories/deployment_repository'
require_relative 'deployments/repositories/deployment_repository/in_memory'
require_relative 'deployments/repositories/deployment_repository/sequel'

require_relative 'deployments/services/github_service'
require_relative 'deployments/services/github_service/octokit_github_service'
require_relative 'deployments/services/github_service/fake_heroku_service'

require_relative 'deployments/services/heroku_service'
require_relative 'deployments/services/heroku_service/api_heroku_service'
require_relative 'deployments/services/heroku_service/fake_heroku_service'

require_relative 'deployments/jobs/deploy_job'

require_relative 'deployments/use_cases/create'
require_relative 'deployments/use_cases/paginate_for_environment'
require_relative 'deployments/use_cases/deploy'
require_relative 'deployments/use_cases/find'

module Deployments
  DeploymentRepository.register :in_memory,  DeploymentRepository::InMemory.new
  DeploymentRepository.register :sequel, DeploymentRepository::Sequel.new

  HerokuService.register :fake, FakeHerokuService.new
  HerokuService.register :api, ApiHerokuService.new

  GithubService.register :fake,    FakeGithubService.new
  GithubService.register :octokit, OctokitGithubService.new(ENV['OCTOKIT_CLIENT_ID'], ENV['OCTOKIT_CLIENT_SECRET'])
end
