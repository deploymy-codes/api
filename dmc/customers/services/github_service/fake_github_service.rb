module Customers
  class FakeGithubService
    FakeUser = Struct.new(:name, :email, :avatar_url)

    def initialize
      @counter = 0
      reset_tokens
    end

    def reset_tokens(_ = nil)
      @tokens = {}
    end

    def fetch_token(code)
      @tokens[code] || add_and_return_token(code)
    end

    def user(oauth_token)
      FakeUser.new('Robots', 'coders@deploymy.codes', 'https://avatars.githubusercontent.com/u/10991964?v=3')
    end

    def orgs(oauth_token)
      [GithubService::Org.new('deploymy-codes', 'avatars.jpg')]
    end

    def repository(oauth_token, owner, repo)
      repositories(oauth_token).find do |repository|
        repository.name == [owner, repo].join('/')
      end
    end

    def repositories(oauth_token)
      [
        GithubService::Repository.new('deploymy-codes/api', 'https://github.com/deploymy-codes/api.git', 25465783),
        GithubService::Repository.new('deploymy-codes/frontend', 'https://github.com/deploymy-codes/frontend.git', 25839116),
        GithubService::Repository.new('deploymy-codes/native', 'https://github.com/deploymy-codes/native.git', 30321370),
      ]
    end

    private

    def add_and_return_token(code)
      token = "github-token-#{@counter}"
      @tokens[code] = token
      @counter += 1
      token
    end

  end
end
