def create_deployment(sha: '3b23ae0', environment: nil)
  form = Deployments::CreateForm.new sha: sha
  Deployments::Create.new(environment, form).run!
end
