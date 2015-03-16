module Deployments
  class FakeHerokuService
    include CommandRunner

    def deploy(project, environment, deployment)
      run(deployment) do |runner|
        runner.execute "Check access on Heroku app: #{environment.app_name}", &method(:check_access)
        runner.execute "Deploy on #{environment.app_name}", &method(:push)
      end
    end

    private

    def check_access(command)
      command.update_log stdout: 'done'
      true
    end

    def push(command)
      command.update_log stdout: 'done'
      true
    end
  end
end
