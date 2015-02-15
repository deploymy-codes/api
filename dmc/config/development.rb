require 'pry'

Customers::UserRepository.use :perpetuity
Customers::AccountRepository.use :perpetuity

Projects::ProjectRepository.use :perpetuity

Environments::EnvironmentRepository.use :perpetuity

Deployments::DeploymentRepository.use :perpetuity

Customers::GithubService.use :octokit

Projects::GitService.use :rugged

JobRunner.use :sync
