require 'spec_helper'

module Environments
  describe 'Update environment' do
    let(:user)        { create_user }
    let(:project)     { create_project user: user }
    let(:environment) { create_environment project: project }
    let(:form)        { EnvironmentForm.new name: 'new_name', strategy: 'heroku', heroku_api_key: 'api_key', heroku_app_name: 'app_name' }

    subject { Update.new(environment, form).run! }

    it 'updates the environment' do
      expect(subject.name).to be_eql 'new_name'
    end

    context 'When environment name is taken' do
      let!(:new_environment) { create_environment name: 'new_name', project: project }

      it 'raise an environment name taken error' do
        expect { subject }.to raise_error NameTakenError
      end
    end

  end
end
