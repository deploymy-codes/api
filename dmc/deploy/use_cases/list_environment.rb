module Deploy
  class ListEnvironment < Struct.new(:project)

    def run!
      ProjectRepository.all_environments_of!(project)
    end

  end
end
