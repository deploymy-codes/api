module Environments
  class PaginateForProject < Struct.new(:project, :cursor)

    def run!
      environments = EnvironmentRepository.paginate_for_project!(project.id, cursor)
      total_count  = EnvironmentRepository.count_for_project!(project.id)

      Envelope.new environments, total_count, cursor
    end

  end
end
