module Deployments
  class CommitDoNotExistError < StandardError
    def initialize(commit)
      @commit = commit
    end

    def message
      "Commit #{@commit} does not exist"
    end
  end

  class DeploymentUnfinishedError < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Environment: #{@name} has at least one unfinished deployment"
    end
  end

  class Create < Struct.new(:environment, :form)

    def run!
      form.validate!
      validate_no_deployment_unfinished!
      validate_commit_existence!

      deployment = Deployment.build(form.sha, environment.id)
      DeploymentRepository.save deployment
      JobRunner.perform DeployJob, deployment.id

      deployment
    end

    private

    def validate_no_deployment_unfinished!
      deployments = DeploymentRepository.all_for_environment_and_states!(environment.id, Deployment::UNFINISH_STATE)

      raise DeploymentUnfinishedError, environment.name if deployments.any?
    end

    def validate_commit_existence!
      commit = Projects::FindCommit.new(environment.project_id, form.sha).run!
      raise CommitDoNotExistError, form.sha if commit.blank?
    end

  end
end
