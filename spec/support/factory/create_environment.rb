def create_environment(project: nil, name: 'master', strategy: 'heroku')
  environment_form = Environments::EnvironmentForm.new name: name, strategy: strategy
  Environments::CreateEnvironment.new(project, environment_form).run!
end
