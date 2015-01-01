require 'spec_helper'

module Deploy
  describe 'List project' do

    it 'list project which belongs to the user' do
      form = Customer::CodeForm.new code: 'code'
      user = Customer::FindOrCreateUser.new('github', form).run!

      remote_project = Customer::RemoteProject.new(name: 'rails', url: 'http://www.google.com')
      project = CreateProject.new(user, remote_project).run!

      projects = ListProject.new(user).run!

      expect(projects.first.id).to be_eql project.id
      expect(projects.first.name).to be_eql project.name
      expect(projects.first.user_id).to be_eql project.user_id
    end
  end
end
