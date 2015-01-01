require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customer::UserRepository.use :perpetuity
  Deploy::ProjectRepository.use :perpetuity
else
  Customer::UserRepository.use :in_memory
  Deploy::ProjectRepository.use :in_memory
end

Customer::GithubService.use :fake
