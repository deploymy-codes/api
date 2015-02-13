require 'spec_helper'

module Deployments
  describe 'Create deployment' do
    let(:user)        { create_user }
    let(:project)     { create_project user: user }
    let(:environment) { create_environment project: project }

    subject { Create.new(environment, form).run! }

    context 'when form is valid' do
      let(:form) { CreateForm.new commit: 'a1wn' }

      it 'create a deployment' do
        expect(subject.commit).to be_eql form.commit
        expect(subject.id).to_not be_nil
        expect(subject.environment_id).to be_eql environment.id
        expect(subject.state).to be_eql 'pending'
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
