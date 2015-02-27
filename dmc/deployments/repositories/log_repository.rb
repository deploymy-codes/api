module Deployments
  class LogRepository < Repository

    class << self
      def all_for_deployment!(deployment_id)
        query Log, LogWithDeploymentId.new(deployment_id)
      end
    end

  end

  LogWithDeploymentId = Struct.new :deployment_id
end
