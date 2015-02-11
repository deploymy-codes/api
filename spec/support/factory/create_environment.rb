def create_environment(project: nil, name: 'master', strategy: 'heroku')
  environment_form = Environments::CreateForm.new name: name, strategy: strategy
  Environments::Create.new(project, environment_form).run!
end
