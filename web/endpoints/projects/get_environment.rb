module Endpoint
  class Projects < Web
    module GetEnvironment

      def self.registered(app)
        app.get '/:project_name/environments/:environment_name' do |_, _|
          json serialize(current_environment)
        end

        app.error Environments::EnvironmentRepository::UnknownNameError do
          halt_json_error 404
        end
      end

    end
  end
end
