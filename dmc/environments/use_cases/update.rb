module Environments
  class Update < Struct.new(:environment, :form)

    def run!
      form.validate!
      validate_environment_uniqueness!

      environment.attributes = form.attributes
      EnvironmentRepository.save environment

      environment
    end

    private

    def project
      @project ||= Projects::Find.new(environment.project_id).run!
    end

    def environment_names
      @environment_names ||= ListForProject.new(project).run!.select do |e|
        e.id != environment.id
      end.map(&:name)
    end

    def validate_environment_uniqueness!
      if environment_names.include? form.name
        raise NameTakenError, form.name
      end
    end

  end
end
