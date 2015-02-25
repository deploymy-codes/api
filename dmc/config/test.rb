require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customers::UserRepository.use :sequel
  Customers::AccountRepository.use :sequel

  Projects::ProjectRepository.use :sequel

  Environments::EnvironmentRepository.use :sequel

  Deployments::DeploymentRepository.use :sequel
  Deployments::LogRepository.use :sequel

  Customers::GithubService.use :octokit

  Projects::GitService.use :gitlab

  Deployments::HerokuService.use :api
  Deployments::GithubService.use :octokit
else
  Customers::UserRepository.use :in_memory
  Customers::AccountRepository.use :in_memory

  Projects::ProjectRepository.use :in_memory

  Environments::EnvironmentRepository.use :in_memory

  Deployments::DeploymentRepository.use :in_memory
  Deployments::LogRepository.use :in_memory

  Customers::GithubService.use :fake

  Projects::GitService.use :fake

  Deployments::HerokuService.use :fake
  Deployments::GithubService.use :fake
end

JobRunner.use :sync
