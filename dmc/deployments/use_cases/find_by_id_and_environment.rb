module Deployments
  class WrongEnvironmentError
    def initialize(name)
      @name = name
    end

    def message
      "Deployment is not associated to environment: #{@name}"
    end
  end

  class FindByIdAndEnvironment < Struct.new(:id, :environment)

    def run!
      deployment = Find.new(id).run!

      if deployment.environment_id != environment.id
        raise WrongEnvironmentError environment.name
      end

      deployment
    end

  end
end
