module Customers
  class GetRemoteProject < Struct.new(:user, :owner, :repo)

    def run!
      account        = AccountRepository.find_by_provider_and_user_id! 'github', user.id
      remote_project = GithubService.repository(account.oauth_token, owner, repo)

      raise RemoteProjectNotFound, name unless remote_project

      remote_project
    end

  end
end
