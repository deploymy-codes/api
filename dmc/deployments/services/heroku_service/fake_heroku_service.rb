module Deployments
  class FakeHerokuService
    include CommandRunner

    def deploy(project, environment, deployment)
      run(deployment) do |runner|
        runner.execute "Check access on Heroku app: #{environment.heroku_app_name}", &method(:check_access)
        runner.execute "Deploy on #{environment.heroku_app_name}", &method(:push)
      end
    end

    private

    def check_access(log)
      log.stdout = 'done'
      true
    end

    def push(log)
      log.stdout = 'done'
      true
    end
  end
end
