require 'spec_helper'

module Environments
  describe 'Create environment' do
    before do
      user         = create_user
      @project     = create_project name: 'rails', user: user

      @form        = EnvironmentForm.new name: 'foo', strategy: 'heroku'
      @environment = CreateEnvironment.new(@project, @form).run!
    end

    it 'create an environment' do
      expect(@environment.name).to be_eql 'foo'
      expect(@environment.strategy).to be_eql 'heroku'
    end

    context 'When environment name is taken' do
      it 'raise an environment name taken error' do
        expect { CreateEnvironment.new(@project, @form).run! }.to raise_error EnvironmentNameTakenError
      end
    end

  end
end
