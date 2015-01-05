require 'spec_helper'

module Deploy
  describe 'Create environment' do

    it 'create an environment' do
      user        = create_user
      project     = create_project name: 'rails', user: user

      form        = EnvironmentForm.new name: 'foo', strategy: 'heroku'
      environment = CreateEnvironment.new(project, form).run!

      expect(environment.name).to be_eql 'foo'
      expect(environment.strategy).to be_eql 'heroku'
    end

  end
end
