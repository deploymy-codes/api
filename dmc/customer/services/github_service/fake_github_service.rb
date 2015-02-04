module Customer
  class FakeGithubService
    FakeUser = Struct.new(:name, :email, :avatar_url)

    def initialize
      @counter = 0
      reset_tokens
    end

    def reset_tokens
      @tokens = {}
    end

    def fetch_token(code)
      @tokens[code] || add_and_return_token(code)
    end

    def user(oauth_token)
      FakeUser.new('Aaron Patterson', 'aaron@tenderlove.org', 'https://avatars0.githubusercontent.com/u/3124?v=3')
    end

    def repositories(oauth_token)
      [
        GithubService::Repository.new('rails',      'https://github.com/rails/rails'),
        GithubService::Repository.new('activeform', 'https://github.com/rails/activeform'),
        GithubService::Repository.new('turbolinks', 'https://github.com/rails/turbolinks')
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
