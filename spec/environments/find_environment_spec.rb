require 'spec_helper'

module Environments
  describe 'Find Environment' do
    let(:user) { create_user }
    let(:project) { create_project name: 'rails', user: user}

    context 'When environment is not found' do
      it 'raise a record not found error' do
        expect {
          FindEnvironment.new(nil, project).run!
        }.to raise_error EnvironmentRepository::UnknownEnvironmentNameError
      end
    end

    context 'When environment is found' do
      let!(:environment) { create_environment project: project}

      it 'returns the environment' do
        result_environment = FindEnvironment.new('master', project).run!

        expect(result_environment.name).to be_eql 'master'
      end
    end

  end
end
