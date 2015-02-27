def create_deployment(sha: ENV['GIT_COMMIT_ID'], environment: nil)
  form = Deployments::CreateForm.new sha: sha
  Deployments::Create.new(environment, form).run!
end
