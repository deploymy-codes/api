module Deploy
  class CreateProject < Struct.new(:user, :remote_project)

    def run!
      project = Project.build_from user: user, remote_project: remote_project

      ProjectRepository.save project

      project
    end

  end
end
