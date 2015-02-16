$stdout.sync = true
$stderr.sync = true

Customers::UserRepository.use :perpetuity
Customers::AccountRepository.use :perpetuity

Projects::ProjectRepository.use :perpetuity

Environments::EnvironmentRepository.use :perpetuity

Deployments::DeploymentRepository.use :perpetuity

Customers::GithubService.use :octokit

Projects::GitService.use :rugged

DeploymentRepository::HerokuService.use :api

JobRunner.use :async
