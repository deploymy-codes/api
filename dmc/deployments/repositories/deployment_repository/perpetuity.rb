module Deployments
  class DeploymentRepository
    class Perpetuity < ::Repository::Adapter::Perpetuity

      def query_deployment_with_environment_id(klass, selector)
        mapper_for(klass).select { |deployment| deployment.environment_id == selector.environment_id }.to_a
      end

      def clear
        mapper_for(Deployment).delete_all
      end

    end
  end
end
