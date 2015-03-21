require 'spec_helper'

module Projects
  describe 'List project' do

    it 'list project which belongs to the user' do
      user = create_user

      remote_project = Customers::RemoteProject.new(full_name: 'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
      project = Create.new(user, remote_project).run!

      projects = ListForUser.new(user).run!

      expect(projects.first.id).to be_eql project.id
      expect(projects.first.name).to be_eql project.name
      expect(projects.first.user_id).to be_eql project.user_id
    end
  end
end
