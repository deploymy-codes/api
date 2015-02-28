module Deployments
  class DeploymentRepository < Repository

    class << self
      def paginate_for_environment!(environment_id, cursor)
        query Deployment, PaginateDeploymentWithEnvironmentId.new(environment_id, cursor.limit, cursor.offset)
      end

      def all_for_environment_and_states!(environment_id, states)
        query Deployment, DeploymentWithEnvironmentIdAndStates.new(environment_id, states)
      end

      def count_for_environment!(environment_id)
        query Deployment, CountDeploymentWithEnvironmentId.new(environment_id)
      end
    end

  end

  CountDeploymentWithEnvironmentId     = Struct.new :environment_id
  PaginateDeploymentWithEnvironmentId  = Struct.new :environment_id, :limit, :offset
  DeploymentWithEnvironmentIdAndStates = Struct.new :environment_id, :states
end
