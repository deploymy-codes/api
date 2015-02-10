require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customers::UserRepository.use :perpetuity
  Projects::ProjectRepository.use :perpetuity
  Environments::EnvironmentRepository.use :in_memory
else
  Customers::UserRepository.use :in_memory
  Projects::ProjectRepository.use :in_memory
  Environments::EnvironmentRepository.use :in_memory
end

Customers::GithubService.use :fake
