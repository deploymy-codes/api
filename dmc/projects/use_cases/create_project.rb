module Projects
  class ProjectNameTakenError < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Project name #{@name} is already taken"
    end
  end

  class CreateProject < Struct.new(:user, :remote_project)

    def run!
      validate_project_uniqueness!

      project = Project.build_from user: user, remote_project: remote_project

      ProjectRepository.save project
      add_environment! project

      project
    end

    private

    def add_environment!(project)
      form = Environments::EnvironmentForm.new name: 'default', strategy: ''
      Environments::CreateEnvironment.new(project, form).run!
    end

    def validate_project_uniqueness!
      if ListProject.new(user).run!.map(&:name).include? remote_project.name
        raise ProjectNameTakenError, remote_project.name
      end
    end
  end
end
