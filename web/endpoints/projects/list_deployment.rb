module Endpoint
  class Projects < Web
    module ListDeployment

      def self.registered(app)
        app.get '/:owner/:repo/environments/:environment_name/deployments' do
          use_case = Deployments::PaginateForEnvironment.new current_environment, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
