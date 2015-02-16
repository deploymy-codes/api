module Deployments
  class Deploy < Struct.new(:deployment)

    def run!
      environment = Environments::Find.new(deployment.environment_id).run!
    end

  end
end
