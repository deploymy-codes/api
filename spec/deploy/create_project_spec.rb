require 'spec_helper'

module Deploy
  describe 'Create project' do

    it 'create the project based on the user and the remote project' do
      user = create_user

      remote_projects = Customer::ListRemoteProject.new(user).run!

      project = CreateProject.new(user, remote_projects.first).run!

      expect(project.id).to_not be_nil
      expect(project.name).to be_eql 'rails'
      expect(project.user_id).to be_eql user.id
    end
  end
end
