def create_deployment(commit: 'asf', environment: nil)
  form = Deployments::CreateForm.new commit: commit
  Deployments::Create.new(environment, form).run!
end
