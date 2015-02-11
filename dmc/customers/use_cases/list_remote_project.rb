module Customers
  class ListRemoteProject < Struct.new(:user)

    def run!
      account      = AccountRepository.find_by_provider_and_user_id! 'github', user.id
      repositories = GithubService.repositories account.oauth_token

      repositories.map { |repository| RemoteProject.new(repository.to_hash) }
    end

  end
end
