module Endpoint
  class Projects < Web
    module ListDeployment

      def self.registered(app)
        app.get '/:owner/:repo/environments/:environment_name/deployments' do
          use_case     = Deployments::List.new current_environment
          deployments  = use_case.run!

          json serialize(deployments)
        end
      end

    end
  end
end
