require 'spec_helper'

module Environments
  describe 'Create environment' do
    before do
      user         = create_user
      @project     = create_project full_name: 'rails', user: user

      @form        = EnvironmentForm.new name: 'foo', strategy: 'heroku', heroku_api_key: 'api_key', heroku_app_name: 'app_name'
      @environment = Create.new(@project, @form).run!
    end

    it 'create an environment' do
      expect(@environment.name).to be_eql 'foo'
      expect(@environment.strategy).to be_eql 'heroku'
      expect(@environment.heroku_api_key).to be_eql 'api_key'
      expect(@environment.heroku_app_name).to be_eql 'app_name'
    end

    context 'When environment name is taken' do
      it 'raise an environment name taken error' do
        expect { Create.new(@project, @form).run! }.to raise_error NameTakenError
      end
    end

  end
end
