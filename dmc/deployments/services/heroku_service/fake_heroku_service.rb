module Deployments
  class FakeHerokuService
    include CommandRunner

    def deploy(project, environment, deployment)
      run(project, environment, deployment) do |runner|
        runner.execute "Check access on Heroku app: #{environment.heroku_app_name}", &check_access
        runner.execute "Deploy on #{environment.heroku_app_name}", &push
      end
    end

    private

    def check_access
      Proc.new do |log|
        log.stdout = 'done'
        true
      end
    end

    def push
      Proc.new do |log|
        log.stdout = 'done'
        true
      end
    end
  end
end
