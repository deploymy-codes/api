require 'pry'

Customer::UserRepository.use :in_memory

Customer::GithubService.use :fake
