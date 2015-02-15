module Endpoint
  class Projects < Web
    module CreateDeployment

      def self.registered(app)
        app.post '/:project_name/environments/:environment_name/deployments' do |project_name, environment_name|
          form     = Deployments::CreateForm.new extract!(:deployment)
          use_case = Deployments::Create.new current_environment, form

          deployment = use_case.run!

          json serialize(deployment)
        end
      end

    end
  end
end
