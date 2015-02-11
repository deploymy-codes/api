require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customers::UserRepository.use :perpetuity
  Customers::AccountRepository.use :perpetuity

  Projects::ProjectRepository.use :perpetuity

  Environments::EnvironmentRepository.use :perpetuity
else
  Customers::UserRepository.use :in_memory
  Customers::AccountRepository.use :in_memory

  Projects::ProjectRepository.use :in_memory

  Environments::EnvironmentRepository.use :in_memory
end

Customers::GithubService.use :fake
