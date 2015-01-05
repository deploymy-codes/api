def create_environment(project: nil, name: 'master', strategy: 'heroku')
  environment_form = Deploy::EnvironmentForm.new name: name, strategy: strategy
  Deploy::CreateEnvironment.new(project, environment_form).run!
end
