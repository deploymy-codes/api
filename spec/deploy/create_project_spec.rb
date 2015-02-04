require 'spec_helper'

module Deploy
  describe 'Create project' do
    before do
      @user            = create_user
      @remote_projects = Customer::ListRemoteProject.new(@user).run!
      @project         = CreateProject.new(@user, @remote_projects.first).run!
    end

    it 'create the project based on the user and the remote project' do
      expect(@project.id).to_not be_nil
      expect(@project.name).to be_eql 'rails'
      expect(@project.user_id).to be_eql @user.id
    end

    it 'create a default environment' do
      expect(@project.environments.count).to be 1
    end

    context 'When project name is taken' do
      it 'raise a project name taken error' do
        expect { CreateProject.new(@user, @remote_projects.first).run! }.to raise_error ProjectNameTakenError
      end
    end
  end
end
