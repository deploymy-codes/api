module Deployments
  class CommitDoNotExistError < StandardError
    def initialize(commit)
      @commit = commit
    end

    def message
      "Commit #{@commit} does not exist"
    end
  end

  class Create < Struct.new(:environment, :form)

    def run!
      form.validate!
      validate_commit_existence!

      deployment = Deployment.build(form.sha, environment.id)
      DeploymentRepository.save deployment
      JobRunner.perform DeployJob, deployment.id

      deployment
    end

    private

    def validate_commit_existence!
      commit = Projects::FindCommit.new(environment.project_id, form.sha).run!
      raise CommitDoNotExistError, form.sha if commit.blank?
    end

  end
end
