require 'pry'

mode = ENV.fetch 'MODE', 'fast'
if mode == 'ci'
  Customer::UserRepository.use :active_record
else
  Customer::UserRepository.use :in_memory
end

Customer::GithubService.use :fake
