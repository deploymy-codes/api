Repo.register :in_memory, Repo::Adapter::InMemory.new
Repo.use :in_memory

Customer::GithubService.register :fake, Customer::FakeGithubService.new
Customer::GithubService.use :fake
