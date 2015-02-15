module Deployments
  class DeploymentRepository < Repository

    class << self
      def all_for_environment!(environment_id)
        query Deployment, DeploymentWithEnvironmentId.new(environment_id)
      end
    end

  end

  DeploymentWithEnvironmentId = Struct.new :environment_id
end
