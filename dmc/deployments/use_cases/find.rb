module Deployments
  class Find < Struct.new(:id)

    def run!
      DeploymentRepository.find(Deployment, id)
    end

  end
end
