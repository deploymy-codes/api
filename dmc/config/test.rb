require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customer::UserRepository.use :perpetuity
else
  Customer::UserRepository.use :in_memory
end

Customer::GithubService.use :fake
