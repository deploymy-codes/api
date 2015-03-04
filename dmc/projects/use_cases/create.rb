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
      JobRunner.perform CloneJob, project.id

      project
    end

    private

    def add_environment!(project)
      form = Environments::EnvironmentForm.new({
        name:     Environments::Environment::DEFAULT_NAME,
        strategy: Environments::Environment::DEFAULT_STRATEGY,
        heroku_api_key: 'Replace by your api key',
        heroku_app_name: 'Replace by your app name',
      })

      Environments::Create.new(project, form).run!
    end

    def validate_project_uniqueness!
      if ListForUser.new(user).run!.map(&:name).include? remote_project.full_name
        raise NameTakenError, remote_project.full_name
      end
    end
  end
end
