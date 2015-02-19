module Customers
  class ListRemoteOrg < Struct.new(:user)

    def run!
     orgs = GithubService.orgs(account.oauth_token)

     orgs.map { |org| RemoteOrg.new org.to_hash }
    end

    private

    def account
      @account ||= AccountRepository.find_by_provider_and_user_id! 'github', user.id
    end

  end
end
