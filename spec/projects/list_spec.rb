require 'spec_helper'

module Projects
  describe 'List project' do

    it 'list project which belongs to the user' do
      user = create_user

      remote_project = Customers::RemoteProject.new(name: 'rails', url: 'http://www.google.com')
      project = Create.new(user, remote_project).run!

      projects = List.new(user).run!

      expect(projects.first.id).to be_eql project.id
      expect(projects.first.name).to be_eql project.name
      expect(projects.first.user_id).to be_eql project.user_id
    end
  end
end
