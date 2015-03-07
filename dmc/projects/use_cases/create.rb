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
      JobRunner.perform CloneJob, project.id

      project
    end

    private

    def validate_project_uniqueness!
      if ListForUser.new(user).run!.map(&:name).include? remote_project.full_name
        raise NameTakenError, remote_project.full_name
      end
    end
  end
end
