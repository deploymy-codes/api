require 'pry'

Customer::UserRepository.use :in_memory
Deploy::ProjectRepository.use :in_memory

Customer::GithubService.use :fake
