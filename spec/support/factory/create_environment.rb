def create_environment(project: nil, name: 'master', strategy: 'heroku')
  form = Environments::FactoryForm.build({
    name: name,
    strategy: strategy,
  }.merge(self.send(strategy)))

  Environments::Create.new(project, form).run!
end

def heroku
  {
    api_key: ENV['HEROKU_API_KEY'],
    app_name: ENV['HEROKU_APP_NAME'],
  }
end

def rubygem
  {
    api_key: ENV['RUBYGEM_API_KEY']
  }
end
