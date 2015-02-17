module Deployments
  class Deploy < Struct.new(:deployment)

    def run!
      strategy.deploy deployment
    end

    private

    def environment
      @environment ||= Environments::Find.new(deployment.environment_id).run!
    end

    def strategy
      "Deployments::#{environment.strategy.classify}Service".constantize
    end

  end
end
