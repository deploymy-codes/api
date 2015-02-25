require 'pry'

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

JobRunner.use :sync
