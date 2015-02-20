module Deployments
  class DeploymentRepository < Repository

    class << self
      def paginate_for_environment!(environment_id, cursor)
        query Deployment, PaginateDeploymentWithEnvironmentId.new(environment_id, cursor.limit, cursor.offset)
      end

      def count_for_environment!(environment_id)
        query Deployment, CountDeploymentWithEnvironmentId.new(environment_id)
      end
    end

  end

  CountDeploymentWithEnvironmentId    = Struct.new :environment_id
  PaginateDeploymentWithEnvironmentId = Struct.new :environment_id, :limit, :offset
end
