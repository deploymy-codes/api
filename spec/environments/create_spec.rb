require 'spec_helper'

module Environments
  describe 'Create environment' do
    before do
      user         = create_user
      @project     = create_project name: 'rails', user: user

      @form        = CreateForm.new name: 'foo', strategy: 'heroku'
      @environment = Create.new(@project, @form).run!
    end

    it 'create an environment' do
      expect(@environment.name).to be_eql 'foo'
      expect(@environment.strategy).to be_eql 'heroku'
    end

    context 'When environment name is taken' do
      it 'raise an environment name taken error' do
        expect { Create.new(@project, @form).run! }.to raise_error NameTakenError
      end
    end

  end
end
