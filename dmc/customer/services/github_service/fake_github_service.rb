module Customer
  class FakeGithubService
    FakeUser = Struct.new(:name, :email)

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
      FakeUser.new('Aaron Patterson', 'aaron@tenderlove.org')
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

