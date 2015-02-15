module Projects
  class NameTakenError < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Project name #{@name} is already taken"
    end
  end

  class Create < Struct.new(:user, :remote_project)

    def run!
      validate_project_uniqueness!

      project = Project.build_from user: user, remote_project: remote_project

      ProjectRepository.save project
      add_environment! project
      JobRunner.perform CloneJob, project

      project
    end

    private

    def add_environment!(project)
      form = Environments::CreateForm.new({
        name:     Environments::Environment::DEFAULT_NAME,
        strategy: Environments::Environment::DEFAULT_STRATEGY
      })

      Environments::Create.new(project, form).run!
    end

    def validate_project_uniqueness!
      if List.new(user).run!.map(&:name).include? remote_project.name
        raise NameTakenError, remote_project.name
      end
    end
  end
end
