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
        { name: 'rails',      url: 'https://github.com/rails/rails' },
        { name: 'activeform', url: 'https://github.com/rails/activeform' },
        { name: 'turbolinks', url: 'https://github.com/rails/turbolinks' }
      ]
    end

  end
end
