module Deploy
  class CreateProject < Struct.new(:user, :remote_project)

    def run!
      project = Project.build_from user: user, remote_project: remote_project

      ProjectRepository.save project
      add_environment! project

      project
    end

    private

    def add_environment!(project)
      form = EnvironmentForm.new name: 'default', strategy: ''
      CreateEnvironment.new(project, form).run!
    end

  end
end
