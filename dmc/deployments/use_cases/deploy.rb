module Deployments
  class Deploy < Struct.new(:deployment)

    def run!
      deployment.state = :in_progress
      DeploymentRepository.save deployment

      CreateRelease.new(project, environment, deployment).run!

      runner = strategy.deploy project, environment, deployment

      deployment.state = runner.result
      DeploymentRepository.save deployment
    end

    private

    def project
      @project ||= Projects::Find.new(environment.project_id).run!
    end

    def environment
      @environment ||= Environments::Find.new(deployment.environment_id).run!
    end

    def strategy
      "Deployments::#{environment.strategy.classify}Service".constantize
    end

  end
end
