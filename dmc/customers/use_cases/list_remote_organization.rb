module Customers
  class ListRemoteOrganization < Struct.new(:user)

    def run!
     organizations = GithubService.organizations(account.oauth_token)

     organizations.map { |organization| RemoteOrganization.new organization.to_hash }
    end

    private

    def account
      @account ||= AccountRepository.find_by_provider_and_user_id! 'github', user.id
    end

  end
end
