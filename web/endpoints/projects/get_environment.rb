module Endpoint
  class Projects < Web
    module GetEnvironment

      def self.registered(app)
        app.get '/:owner/:repo/environments/:environment_name' do
          json serialize(current_environment)
        end

        app.error Environments::EnvironmentRepository::UnknownNameError do
          halt_json_error 404
        end
      end

    end
  end
end
