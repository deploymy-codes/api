module Customers
  class ListRemoteProject < Struct.new(:user)

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
      @account ||= AccountRepository.find_by_provider_and_user_id! 'github', user.id
    end

    def repositories
      @repositories ||= GithubService.repositories account.oauth_token
    end

  end
end
