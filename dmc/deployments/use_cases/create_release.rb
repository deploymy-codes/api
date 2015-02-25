module Deployments
  class CreateRelease < Struct.new(:project, :environment, :deployment)

    def run!
      release = GithubService.create_release account.oauth_token, project.name, release_name, deployment.sha

      deployment.release = release
      DeploymentRepository.save deployment

      release
    end

    private

    def account
      @account ||= Customers::GetAccount.new('github', project.user_id).run!
    end

    def release_name
      @release_name ||= "#{environment.name}-#{Time.now.strftime('%Y%m%d%H%M%S')}"
    end

  end
end
