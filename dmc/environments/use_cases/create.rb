module Environments
  class Create < Struct.new(:project, :form)

    def run!
      form.validate!
      validate_environment_uniqueness!

      environment = environment_klass.new form.attributes
      environment.project_id = project.id

      EnvironmentRepository.save environment

      environment
    end

    private

    def environment_klass
      "Environments::#{form.type.classify}Environment".constantize
    end

    def validate_environment_uniqueness!
      if ListForProject.new(project).run!.map(&:name).include? form.name
        raise NameTakenError, form.name
      end
    end

  end
end
