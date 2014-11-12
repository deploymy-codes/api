Repo.register :in_memory, Repo::InMemory.new
Repo.use :in_memory

Customer::GithubService.register :fake, Customer::FakeGithubService.new
Customer::GithubService.use :fake
