module Deployments
  class DeployJob
    include Sidekiq::Worker

    def perform(deployment_id)
      deployment = Find.new(deployment_id).run!
      Deploy.new(deployment).run!
    end

  end
end
