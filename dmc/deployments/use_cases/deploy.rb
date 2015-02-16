module Deployments
  class Deploy < Struct.new(:deployment)

    def run!
      environment = Environments::Find.new(deployment.environment_id).run!

      "Deployments::#{environment.strategy.classify}Service".constantize.deploy deployment
    end

  end
end
