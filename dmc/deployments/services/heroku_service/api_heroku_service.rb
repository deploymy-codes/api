module Deployments
  class ApiHerokuService

    def deploy(_, environment, deployment)
      Deployer.new(environment, deployment).deploy
    end

    class Deployer < Struct.new(:environment, :deployment)
      include CommandRunner

      def deploy
        run(deployment) do |runner|
          runner.execute "Check access on Heroku app: #{environment.heroku_app_name}", &method(:check_access)
          runner.execute "Deploy on #{environment.heroku_app_name}", &method(:push)
        end
      end

      private

      def check_access(log)
        log.stdout = client.app.info(environment.heroku_app_name)
      end

      def push(log)
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

        build_info['status'] == 'succeeded'
      end

      def client
        @client ||= PlatformAPI.connect(environment.heroku_api_key)
      end
    end

  end
end
