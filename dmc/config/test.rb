require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customers::UserRepository.use :perpetuity
  Customers::AccountRepository.use :perpetuity

  Projects::ProjectRepository.use :perpetuity

  Environments::EnvironmentRepository.use :perpetuity

  Deployments::DeploymentRepository.use :perpetuity

  Customers::GithubService.use :octokit
else
  Customers::UserRepository.use :in_memory
  Customers::AccountRepository.use :in_memory

  Projects::ProjectRepository.use :in_memory

  Environments::EnvironmentRepository.use :in_memory

  Deployments::DeploymentRepository.use :in_memory

  Customers::GithubService.use :fake
end

JobRunner.use :sync
