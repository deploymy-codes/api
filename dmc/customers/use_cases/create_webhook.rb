module Customers
  class CreateWebhook < Struct.new(:user, :remote_project)

    def run!
      account = GetAccount.new('github', user.id).run!
      GithubService.create_webhook(account.oauth_token, remote_project.full_name)
    end

  end
end
