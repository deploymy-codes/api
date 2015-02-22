module Customers
  class ListRemoteOrganizationProject < Struct.new(:user, :owner)

    def run!
      remote_projects.each do |remote_project|
        next unless projects.find { |project| project.remote_id == remote_project.id }
        remote_project.imported = true
      end
    end

    private

    def projects
      @projects ||= Projects::ListForUser.new(user).run!
    end

    def remote_projects
      @remote_projects ||= repositories.map { |repository| RemoteProject.new(repository.to_hash) }
    end


    def account
      @account ||= GetAccount.new('github', user.id).run!
    end

    def repositories
      @repositories ||= GithubService.organization_repositories account.oauth_token, owner
    end

  end
end
