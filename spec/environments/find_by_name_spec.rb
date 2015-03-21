require 'spec_helper'

module Environments
  describe 'Find Environment by name' do
    let(:user) { create_user }
    let(:project) { create_project user: user}

    context 'When environment is not found' do
      it 'raise a record not found error' do
        expect {
          FindByName.new(nil, project).run!
        }.to raise_error EnvironmentRepository::UnknownNameError
      end
    end

    context 'When environment is found' do
      let!(:environment) { create_environment project: project}

      it 'returns the environment' do
        result_environment = FindByName.new('master', project).run!

        expect(result_environment.name).to be_eql 'master'
      end
    end

  end
end
