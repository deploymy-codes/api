module Endpoint
  class Projects < Web
    module CreateEnvironment

      def self.registered(app)
        app.post '/:project_name/environments' do |project_name|
          form         = Environments::CreateForm.new extract!(:environment)
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
