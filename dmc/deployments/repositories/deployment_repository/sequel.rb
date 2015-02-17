module Deployments
  class DeploymentRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_deployment_with_environment_id(klass, selector)
        mapper_for(klass).where(environment_id: selector.environment_id).to_a
      end

      def clear
        mapper_for(Deployment).delete
      end

    end
  end
end
