module Deployments
  class LogRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_log_with_deployment_id(klass, selector)
        all(klass).select do |log|
          log.deployment_id == selector.deployment_id
        end
      end

    end
  end
end
