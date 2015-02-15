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
      end

    end
  end
end
