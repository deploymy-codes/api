module Deployments
  class List < Struct.new(:environment)

    def run!
      DeploymentRepository.all_for_environment!(environment.id)
    end

  end
end
