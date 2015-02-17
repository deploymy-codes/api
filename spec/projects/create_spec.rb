require 'spec_helper'

module Projects
  describe 'Create project' do
    before do
      @user            = create_user
      @remote_projects = Customers::ListRemoteProject.new(@user, Cursor.new).run!.data
      @project         = Create.new(@user, @remote_projects.first).run!
    end

    it 'create the project based on the user and the remote project' do
      expect(@project.id).to_not be_nil
      expect(@project.name).to be_eql 'deploymy-codes/api'
      expect(@project.user_id).to be_eql @user.id
    end

    it 'clone the project' do
      expect(File.directory?(@project.dir)).to be true
    end

    it 'create a default environment' do
      environments = Environments::List.new(@project).run!
      expect(environments.length).to be 1
    end

    context 'When project name is taken' do
      it 'raise a project name taken error' do
        expect { Create.new(@user, @remote_projects.first).run! }.to raise_error NameTakenError
      end
    end
  end
end
