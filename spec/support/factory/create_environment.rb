def create_environment(project: nil, name: 'master', strategy: 'heroku')
  environment_form = Environments::CreateForm.new(
    name: name,
    strategy: strategy,
    heroku_api_key: ENV['HEROKU_API_KEY'],
    heroku_app_name: ENV['HEROKU_APP_NAME'],
  )
  Environments::Create.new(project, environment_form).run!
end
