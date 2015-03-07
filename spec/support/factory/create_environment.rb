def create_environment(project: nil, name: 'master', strategy: 'heroku')
  form = Environments::FactoryForm.build({
    name: name,
    strategy: strategy,
  }.merge(self.send(strategy)))
  Environments::Create.new(project, form).run!
end

def heroku
  {
    heroku_api_key: ENV['HEROKU_API_KEY'],
    heroku_app_name: ENV['HEROKU_APP_NAME'],
  }
end

def rubygem
  {
    rubygem_api_key: ENV['RUBYGEM_API_KEY']
  }
end
