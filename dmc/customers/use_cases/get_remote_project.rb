module Customers
  class RemoteProjectNotFound < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Remote project #{@name} not found"
    end
  end
  class GetRemoteProject < Struct.new(:user, :owner, :repo)

    def run!
      account        = AccountRepository.find_by_provider_and_user_id! 'github', user.id
      remote_project = GithubService.repository(account.oauth_token, owner, repo)

      raise RemoteProjectNotFound, repo unless remote_project

      remote_project
    end

  end
end
