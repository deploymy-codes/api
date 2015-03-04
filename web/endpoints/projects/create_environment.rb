module Endpoint
  class Projects < Web
    module CreateEnvironment

      def self.registered(app)
        app.post '/:owner/:repo/environments' do
          form         = Environments::EnvironmentForm.new extract!(:environment)
          use_case     = Environments::Create.new current_project, form
          environment  = use_case.run!

          status 201
          json serialize(environment)
        end

        app.error Environments::NameTakenError do
          halt_json_error 403
        end
      end

    end
  end
end
