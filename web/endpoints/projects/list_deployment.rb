module Endpoint
  class Projects < Web
    module ListDeployment

      def self.registered(app)
        app.get '/:project_name/environments/:environment_name/deployments' do |_, environment_name|
          use_case     = Deployments::List.new current_environment
          deployments  = use_case.run!

          json serialize(deployments)
        end
      end

    end
  end
end
