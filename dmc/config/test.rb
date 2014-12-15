require 'pry'

Customer::UserRepository.use :active_record

Customer::GithubService.use :fake
