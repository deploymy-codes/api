module Customer
  class ListRepositories < Struct.new(:user)

    def run!
      account     = user.find_account 'github'
      repositories = GithubService.repositories account.oauth_token

      repositories.map { |repository| RepositoryProvider.new(repository) }
    end

  end
end
