module Deployments
  class ApiHerokuService
    include CommandRunner

    def deploy(project, environment, deployment)
      check_access
      push
    end

    private

    def check_access
      command.run "Check access on Heroku app: #{environment.heroku_app_name}" do |log|
        client     = client(environment.heroku_api_key)
        log.stdout = client.app.info(deployment.heroku_app_name)
      end
    end

    def push
      command.run "Deploy on #{deployment.heroku_app_name}" do |log|
        client = client(environment.heroku_api_key)

        build_info  = client.build.create(
          environment.heroku_app_name,
          source_blob: {
            url: deployment.release
          }
        )

        status = build_info['status']
        while !%w(failed succeeded).include?(status)
          sleep 5
          build_info = client.build.info(deployment.heroku_app_name, build_info['id'])
          status     = build_info['status']
        end

        log.stdout = build_info
      end
    end

    def client(api_key)
      PlatformAPI.connect(api_key)
    end

  end
end
