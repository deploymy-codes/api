module Deployments
  class LogRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_log_with_deployment_id(klass, selector)
        mapper_for(klass).where(deployment_id: selector.deployment_id).to_a
      end

      def clear
        mapper_for(Log).delete
      end
    end
  end
end
