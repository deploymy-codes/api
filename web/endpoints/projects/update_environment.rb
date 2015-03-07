module Endpoint
  class Projects < Web
    module UpdateEnvironment

      def self.registered(app)
        app.put '/:owner/:repo/environments/:environment_name' do
          form         = Environments::FactoryForm.build extract!(:environment)
          use_case     = Environments::Update.new current_environment, form
          environment  = use_case.run!

          status 200
          json serialize(environment)
        end

        app.error Environments::NameTakenError do
          halt_json_error 403
        end
      end

    end
  end
end
