module Deploy
  class FindEnvironment < Struct.new(:environment_name, :project)

    def run!
      EnvironmentRepository.find_by_name_and_project_id!(environment_name, project.id)
    end

  end
end
