require 'pry'

mode = ENV.fetch 'MODE', 'fast'
# if mode == 'ci'
# else
#   Customer::UserRepository.use :in_memory
# end

Customer::UserRepository.use :perpetuity
Customer::GithubService.use :fake
