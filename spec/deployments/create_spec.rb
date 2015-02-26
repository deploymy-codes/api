require 'spec_helper'

module Deployments
  describe 'Create deployment' do
    let(:user)        { create_user }
    let(:project)     { create_project user: user }
    let(:environment) { create_environment project: project }

    subject { Create.new(environment, form).run! }

    context 'when form is valid' do
      let(:form) { CreateForm.new sha: ENV['GIT_COMMIT_ID'] }

      it 'create a deployment' do
        expect(subject.sha).to be_eql form.sha
        expect(subject.id).to_not be_nil
        expect(subject.environment_id).to be_eql environment.id
      end
    end

    context 'when commit does not exist' do
      let(:form) { CreateForm.new sha: 'bad_sha' }

      it 'raise a commit not found error' do
        expect { subject }.to raise_error CommitDoNotExistError
      end
    end

    context 'when form is not valid' do
      let(:form) { CreateForm.new }

      it 'raise a validation error' do
        expect { subject }.to raise_error ValidationError
      end
    end

  end
end
