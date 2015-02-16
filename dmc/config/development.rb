require 'pry'

Customers::UserRepository.use :sequel
Customers::AccountRepository.use :sequel

Projects::ProjectRepository.use :sequel

Environments::EnvironmentRepository.use :sequel

Deployments::DeploymentRepository.use :sequel

Customers::GithubService.use :octokit

Projects::GitService.use :rugged

JobRunner.use :sync
