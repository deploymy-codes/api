module Customer
  class FakeGithubService
    FakeUser = Struct.new(:name, :email)

    def initialize
      @counter = 0
    end

    def fetch_token(code)
      @counter += 1
      "github-token-#{@counter}"
    end

    def user(oauth_token)
      FakeUser.new('Aaron Patterson', 'aaron@tenderlove.org')
    end

    def repositories(oauth_token)
      [
        GithubService::Repository.new(name: 'rails',      url: 'https://github.com/rails/rails'),
        GithubService::Repository.new(name: 'activeform', url: 'https://github.com/rails/activeform'),
        GithubService::Repository.new(name: 'turbolinks', url: 'https://github.com/rails/turbolinks')
      ]
    end

  end
end
