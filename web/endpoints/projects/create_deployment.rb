module Endpoint
  class Projects < Web
    module CreateDeployment

      def self.registered(app)
        app.post '/:owner/:repo/environments/:environment_name/deployments' do
          form     = Deployments::CreateForm.new extract!(:deployment)
          use_case = Deployments::Create.new current_environment, form

          deployment = use_case.run!

          status 201
          json serialize(deployment)
        end

        app.error Deployments::CommitDoNotExistError do
          halt_json_error 403
        end
      end

    end
  end
end
