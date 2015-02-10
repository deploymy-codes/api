module Environments
  class ListEnvironment < Struct.new(:project)

    def run!
      EnvironmentRepository.all_for_project!(project.id)
    end

  end
end
