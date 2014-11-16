require 'pry'

Customer::UserRepo.register :in_memory, Customer::Repo::Adapter::InMemory.new
Customer::UserRepo.use :in_memory

Customer::GithubService.register :fake, Customer::FakeGithubService.new
Customer::GithubService.use :fake