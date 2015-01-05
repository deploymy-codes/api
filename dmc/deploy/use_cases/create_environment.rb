module Deploy
  class CreateEnvironment < Struct.new(:project, :form)

    def run!
      form.validate!

      environment = Environment.new form.attributes
      project.environments << environment

      ProjectRepository.save project

      environment
    end

  end
end
