require 'pry'

mode = ENV.fetch 'MODE', 'rom'
if mode == 'ci'
  Customer::UserRepository.use :perpetuity
elsif mode == 'rom'
  Customer::UserRepository.use :rom
else
  Customer::UserRepository.use :in_memory
end

Customer::GithubService.use :fake
