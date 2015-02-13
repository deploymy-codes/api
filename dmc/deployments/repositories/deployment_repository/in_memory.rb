module Deployments
  class DeploymentRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_deployment_with_environment_id(klass, selector)
        all(klass).select { |deployment| deployment.environment_id == selector.environment_id }
      end

    end
  end
end
