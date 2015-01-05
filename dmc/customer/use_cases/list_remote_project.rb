module Customer
  class ListRemoteProject < Struct.new(:user)

    def run!
      account     = user.find_account 'github'
      repositories = GithubService.repositories account.oauth_token

      repositories.map { |repository| RemoteProject.new(repository.to_hash) }
    end

  end
end
