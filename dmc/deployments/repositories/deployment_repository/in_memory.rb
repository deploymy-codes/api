module Deployments
  class DeploymentRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_paginate_deployment_with_environment_id(klass, selector)
        all(klass).select do |deployment|
          deployment.environment_id == selector.environment_id
        end.slice(selector.offset, selector.limit)
      end

      def query_count_deployment_with_environment_id(klass, selector)
        all(klass).select do |deployment|
          deployment.environment_id == selector.environment_id
        end.length
      end

    end
  end
end
