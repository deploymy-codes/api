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

  end
end

