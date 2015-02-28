def create_deployment(sha: ENV['GIT_COMMIT_ID'], environment: nil)
  form = Deployments::CreateForm.new sha: sha
  Deployments::Create.new(environment, form).run!
end

def create_unfinished_deployment(sha: ENV['GIT_COMMIT_ID'], environment: nil)
  form = Deployments::CreateForm.new sha: sha
  deployment = Deployments::Create.new(environment, form).run!
  deployment.state = :in_progress

  Deployments::DeploymentRepository.save deployment

  deployment
end
