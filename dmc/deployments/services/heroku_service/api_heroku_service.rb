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
        client.app.info('asd'+environment.heroku_app_name)
        log.stdout = 'ok'
      rescue
        log.stdout = 'No ok'
        false
      end

      def push(log)
        build  = client.build.create(
          environment.heroku_app_name,
          source_blob: {
            url: deployment.release
          }
        )

        status = build['status']
        while !%w(failed succeeded).include?(status)
          sleep 5
          build  = client.build_result.info(environment.heroku_app_name, build['id'])
          status = build['build']['status']
        end

        log.stdout =  build['lines'].map { |line| line['line'] }.join

        status == 'succeeded'
      end

      def client
        @client ||= PlatformAPI.connect(environment.heroku_api_key)
      end
    end

  end
end
