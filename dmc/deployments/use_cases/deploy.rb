module Deployments
  class Deploy < Struct.new(:deployment)

    def run!
      deployment.state = :in_progress
      DeploymentRepository.save deployment

      CreateRelease.new(project, deployment).run!

      result = strategy.deploy project, environment, deployment

      deployment.state = result
      DeploymentRepository.save deployment
    end

    private

    def project
      @project ||= Projects::Find.new(environment_id.project_id).run!
    end

    def environment
      @environment ||= Environments::Find.new(deployment.environment_id).run!
    end

    def strategy
      "Deployments::#{environment.strategy.classify}Service".constantize
    end

  end
end
