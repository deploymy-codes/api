module Deployments
  class PaginateForEnvironment < Struct.new(:environment, :cursor)

    def run!
      deployments = DeploymentRepository.paginate_for_environment!(environment.id, cursor)
      total_count = DeploymentRepository.count_for_environment!(environment.id)

      Envelope.new deployments, total_count, cursor
    end

  end
end
