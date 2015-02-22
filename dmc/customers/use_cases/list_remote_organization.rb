module Customers
  class ListRemoteOrganization < Struct.new(:user)

    def run!
     organizations = GithubService.organizations(account.oauth_token)

     organizations.map { |organization| RemoteOrganization.new organization.to_hash }
    end

    private

    def account
      @account ||= GetAccount.new('github', user.id).run!
    end

  end
end
