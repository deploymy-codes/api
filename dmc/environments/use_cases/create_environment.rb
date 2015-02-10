module Environments
  class EnvironmentNameTakenError < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Environment name #{@name} is already taken"
    end
  end

  class CreateEnvironment < Struct.new(:project, :form)

    def run!
      form.validate!
      validate_environment_uniqueness!

      environment = Environment.new form.attributes
      environment.project_id = project.id

      EnvironmentRepository.save environment

      environment
    end

    private

    def validate_environment_uniqueness!
      if ListEnvironment.new(project).run!.map(&:name).include? form.name
        raise EnvironmentNameTakenError, form.name
      end
    end

  end
end
