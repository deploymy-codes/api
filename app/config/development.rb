#GithubService.register :fake, FakeGithubService.new
#GithubService.use :fake

GithubService.inject FakeGithubService.new
