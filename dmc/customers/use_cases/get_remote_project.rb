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
      account        = GetAccount.new('github', user.id).run!
      remote_project = GithubService.repository(account.oauth_token, owner, repo)

      raise RemoteProjectNotFound, repo unless remote_project

      remote_project
    end

  end
end
