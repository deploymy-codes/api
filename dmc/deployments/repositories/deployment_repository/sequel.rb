module Deployments
  class DeploymentRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_paginate_deployment_with_environment_id(klass, selector)
        mapper_for(klass).where(environment_id: selector.environment_id).limit(selector.limit).offset(selector.offset).to_a
      end

      def query_deployment_with_environment_id_and_states(klass, selector)
        mapper_for(klass).where(environment_id: selector.environment_id, state: selector.states.map(&:to_s)).to_a
      end

      def query_count_deployment_with_environment_id(klass, selector)
        mapper_for(klass).where(environment_id: selector.environment_id).count
      end

      def clear
        mapper_for(Deployment).delete
      end

    end
  end
end
