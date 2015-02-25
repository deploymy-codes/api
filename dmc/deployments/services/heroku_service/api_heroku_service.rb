module Deployments
  class ApiHerokuService
    include CommandRunner

    def deploy(_, environment, deployment)
      run(deployment) do |runner|
        runner.execute "Check access on Heroku app: #{environment.heroku_app_name}", &check_access
        runner.execute "Deploy on #{environment.heroku_app_name}", &push
      end
    end

    private

    def check_access
      Proc.new do |log|
        client     = client(environment.heroku_api_key)
        log.stdout = client.app.info(environment.heroku_app_name)
      end
    end

    def push
      Proc.new do |log|
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
          build_info = client.build.info(environment.heroku_app_name, build_info['id'])
          status     = build_info['status']
        end

        log.stdout = build_info

        build_info['status'] == 'failed' ? false : true
      end
    end

    def client(api_key)
      PlatformAPI.connect(api_key)
    end

  end
end
